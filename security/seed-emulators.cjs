// Synthetic local accounts only. No cloud credentials are read or required.
const { initializeApp, deleteApp } = require('firebase-admin/app');
const { getAuth } = require('firebase-admin/auth');
const { getFirestore, FieldValue } = require('firebase-admin/firestore');

async function seed() {
  // Set endpoints ourselves so environment variables cannot redirect writes.
  process.env.FIREBASE_AUTH_EMULATOR_HOST = '127.0.0.1:9099';
  process.env.FIRESTORE_EMULATOR_HOST = '127.0.0.1:8080';
  const app = initializeApp({ projectId: 'demo-foodloop-auth' });
  try {
    const auth = getAuth(app);
    const db = getFirestore(app);
    for (const [name, role, vendorStatus] of [
      ['student', 'student', 'none'],
      ['vendor', 'vendor', 'approved'],
      ['pending', 'student', 'pending'],
      ['admin', 'admin', 'none'],
    ]) {
      const uid = `local-${name}`;
      const values = {
        email: `${name}@foodloop.test`, password: 'FoodLoop-local-2026!',
        displayName: `Local ${name}`, emailVerified: true,
      };
      try {
        await auth.createUser({ uid, ...values });
      } catch (error) {
        if (error.code !== 'auth/uid-already-exists') throw error;
        await auth.updateUser(uid, values);
      }
      await db.collection('profiles').doc(uid).set({
        displayName: values.displayName, role, vendorStatus,
        createdAt: FieldValue.serverTimestamp(),
      });
    }
    console.log('Seeded four LOCAL accounts. See docs/team-handoff.md.');
  } finally {
    await deleteApp(app);
  }
}
seed().catch(error => { console.error(error.message); process.exitCode = 1; });
