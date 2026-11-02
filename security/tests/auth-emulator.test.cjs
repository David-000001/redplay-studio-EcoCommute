const test = require('node:test');
const assert = require('node:assert/strict');

const { initializeApp, deleteApp } = require('firebase/app');
const {
  getAuth, connectAuthEmulator, createUserWithEmailAndPassword,
  signOut, signInWithEmailAndPassword, sendPasswordResetEmail
} = require('firebase/auth');
const {
  getFirestore, connectFirestoreEmulator, doc, setDoc,
  getDoc, updateDoc, serverTimestamp, terminate
} = require('firebase/firestore');

// This suite only targets local emulators. It is intentionally impossible to
// run against a production Firebase project by supplying project credentials.
const projectId = 'demo-foodloop-auth';
const app = initializeApp({
  apiKey: 'demo-only-not-a-real-firebase-key',
  projectId,
  appId: '1:1234567890:android:demo-only',
}, 'auth-emulator-smoke');
const auth = getAuth(app);
const db = getFirestore(app);
connectAuthEmulator(auth, 'http://127.0.0.1:9099', { disableWarnings: true });
connectFirestoreEmulator(db, '127.0.0.1', 8080);

test.after(async () => {
  await signOut(auth);
  await terminate(db);
  await deleteApp(app);
});

test('real Firebase client emulator: register, secure profile, login and reset', async () => {
  const email = `foodloop-${Date.now()}@example.test`;
  const password = 'safe-demo-password-2026';
  const registered = await createUserWithEmailAndPassword(auth, email, password);
  const uid = registered.user.uid;
  assert.ok(uid);

  // Mirrors FirebaseAuthRepository.registerStudent() in Flutter.
  await setDoc(doc(db, 'profiles', uid), {
    displayName: 'Student Test',
    role: 'student',
    vendorStatus: 'none',
    createdAt: serverTimestamp(),
  });
  const profile = await getDoc(doc(db, 'profiles', uid));
  assert.equal(profile.data().role, 'student');
  assert.equal(profile.data().vendorStatus, 'none');

  // An ordinary account must never grant itself administrator access.
  await assert.rejects(
    updateDoc(doc(db, 'profiles', uid), { role: 'admin' }),
    (error) => error.code === 'permission-denied'
  );

  await signOut(auth);
  assert.equal(auth.currentUser, null);
  const signedIn = await signInWithEmailAndPassword(auth, email, password);
  assert.equal(signedIn.user.uid, uid);
  await sendPasswordResetEmail(auth, email);
});
