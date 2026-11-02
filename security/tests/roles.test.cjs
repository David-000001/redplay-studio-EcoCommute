const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const { initializeTestEnvironment, assertSucceeds, assertFails } =
  require('@firebase/rules-unit-testing');
const { doc, setDoc, getDoc, updateDoc, collection, getDocs, query, where, serverTimestamp } =
  require('firebase/firestore');

let env;
test.before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-foodloop-auth',
    firestore: { rules: fs.readFileSync('firestore.rules', 'utf8') },
  });
});

test.after(async () => {
  await env.cleanup();
});

test.beforeEach(async () => {
  await env.clearFirestore();
});

function context(uid) {
  return env.authenticatedContext(uid).firestore();
}
async function createStudent(uid, name = 'Campus Student') {
  return assertSucceeds(setDoc(doc(context(uid), 'profiles', uid), {
    displayName: name,
    role: 'student',
    vendorStatus: 'none',
    createdAt: serverTimestamp(),
  }));
}
async function seedAdmin(uid = 'admin1') {
  await env.withSecurityRulesDisabled(async (ctx) => {
    await setDoc(doc(ctx.firestore(), 'profiles', uid), {
      displayName: 'Approved administrator',
      role: 'admin',
      vendorStatus: 'none',
      createdAt: serverTimestamp(),
    });
  });
}

test('student registration works, privilege escalation at creation is rejected', async () => {
  await createStudent('studentA');
  await assertFails(setDoc(doc(context('attacker'), 'profiles', 'attacker'), {
    displayName: 'Hacker',
    role: 'admin',
    vendorStatus: 'approved',
    createdAt: serverTimestamp(),
  }));
});

test('student cannot change role to admin or self-approve vendor', async () => {
  await createStudent('studentA');
  const ref = doc(context('studentA'), 'profiles', 'studentA');
  await assertFails(updateDoc(ref, { role: 'admin' }));
  await assertFails(updateDoc(ref, { role: 'vendor', vendorStatus: 'approved' }));
  await assertSucceeds(updateDoc(ref, { vendorStatus: 'pending' }));
  await assertFails(updateDoc(ref, { vendorStatus: 'approved' }));
});

test('pending students cannot publish; approved vendors can', async () => {
  await createStudent('studentA');
  const studentProfile = doc(context('studentA'), 'profiles', 'studentA');
  await assertSucceeds(updateDoc(studentProfile, { vendorStatus: 'pending' }));
  await assertFails(setDoc(doc(context('studentA'), 'listings', 'unauthorized'), {
    vendorId: 'studentA',
  }));
  await seedAdmin();
  await assertSucceeds(updateDoc(doc(context('admin1'), 'profiles', 'studentA'), {
    role: 'vendor',
    vendorStatus: 'approved',
  }));
  await assertSucceeds(setDoc(doc(context('studentA'), 'listings', 'authorized'), {
    vendorId: 'studentA',
  }));
  await assertFails(setDoc(doc(context('studentA'), 'listings', 'spoof'), {
    vendorId: 'someoneElse',
  }));
});

test('non-admin cannot read others profiles or list, admin can review pending', async () => {
  await createStudent('studentA');
  await createStudent('studentB');
  await assertFails(getDoc(doc(context('studentA'), 'profiles', 'studentB')));
  await assertFails(getDocs(collection(context('studentA'), 'profiles')));
  await seedAdmin();
  await assertSucceeds(getDocs(query(collection(context('admin1'), 'profiles'),
    where('vendorStatus', '==', 'none'))));
});

test('admins cannot promote anyone to admin through client rules', async () => {
  await seedAdmin();
  await createStudent('studentA');
  await assertFails(updateDoc(doc(context('admin1'), 'profiles', 'studentA'), {
    role: 'admin',
  }));
  await assertFails(updateDoc(doc(context('admin1'), 'profiles', 'studentA'), {
    role: 'vendor', vendorStatus: 'approved',
  }));
});

test('anonymous users cannot read profiles or create listings', async () => {
  const anonymous = env.unauthenticatedContext().firestore();
  await createStudent('studentA');
  await assertFails(getDoc(doc(anonymous, 'profiles', 'studentA')));
  await assertFails(setDoc(doc(anonymous, 'listings', 'bad'), { vendorId: 'studentA' }));
});
