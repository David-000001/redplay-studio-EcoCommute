// Privileged provisioning: run only in a trusted administrator environment.
const { initializeApp, applicationDefault } = require('firebase-admin/app');
const { getAuth } = require('firebase-admin/auth');
const { getFirestore, FieldValue } = require('firebase-admin/firestore');

async function main() {
  const uid = process.argv[2];
  const confirmation = process.argv[3];
  const projectId = process.env.GOOGLE_CLOUD_PROJECT;
  if (!uid || confirmation !== '--confirm-admin' || !projectId) {
    throw new Error('Usage: GOOGLE_CLOUD_PROJECT=your-project node security/provision-admin.cjs FIREBASE_AUTH_UID --confirm-admin');
  }
  initializeApp({ credential: applicationDefault(), projectId });
  // UID must already exist in Firebase Authentication.
  const user = await getAuth().getUser(uid);
  if (!user.email) throw new Error('Refusing admin provisioning for account without email');
  const ref = getFirestore().collection('profiles').doc(uid);
  const old = await ref.get();
  await ref.set({
    displayName: old.exists ? (old.get('displayName') || 'UM EcoCommute Administrator')
      : 'UM EcoCommute Administrator',
    role: 'admin',
    vendorStatus: 'none',
    createdAt: old.exists ? old.get('createdAt') : FieldValue.serverTimestamp(),
  }, { merge: true });
  console.log('Provisioned admin profile for existing Firebase Authentication UID.');
}
main().catch((error) => {
  console.error('Admin provisioning failed:', error.message);
  process.exitCode = 1;
});
