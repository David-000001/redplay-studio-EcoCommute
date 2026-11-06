# Firebase backend setup — Issue #9

## Status
- **Auth application logic, student/vendor/admin UI and Firestore security rules are implemented in code.**
- **Live setup completed 6 November 2026:** project `um-foodloop`, default Standard Firestore database in Singapore, deployed rules, and a verified owner administrator. See [verification evidence](live-firebase-verification.md). The steps below are for reproducing or maintaining setup, not unfinished prerequisites.
- Don't upload student IDs, private service-account keys, passwords or contact data to this public repository.
- The code uses *configurable* Firebase options, not embedded Firebase credentials.

## Develop before cloud provisioning
Use the [local emulator setup](team-handoff.md). It supplies only synthetic local accounts and needs no Firebase login. Live setup for #24 is now independently verified; local mode remains useful for isolated development.

## 1. Create your Firebase project
1. Visit https://console.firebase.google.com/ and create or select a project under an account the group can administer.
2. Add an **Android app**. Its current package/application ID is `com.example.um_foodloop` (see `android/app/build.gradle.kts`). Prefer choosing a permanent, team-owned application ID first, such as `org.redplaystudio.foodloop`, and update Android package metadata carefully.
3. Enable Authentication → Sign-in method → **Email/Password**.
4. Create Cloud Firestore (choose a region mindful of UM user latency and privacy).
5. Deploy the **reviewed** `firestore.rules` using the Firebase CLI; do not use open test rules on production.
6. Record the selected backend/project region and data retention practices in the team decision log.

## 2. Provide app configuration (locally, not in git)
Populate a local JSON file `firebase.local.json` (ignored by git) with the actual Android Firebase app values:
```json
{
  "FIREBASE_API_KEY": "replace-with-your-firebase-api-key",
  "FIREBASE_APP_ID": "replace-with-firebase-android-app-id",
  "FIREBASE_MESSAGING_SENDER_ID": "replace-with-sender-id",
  "FIREBASE_PROJECT_ID": "replace-with-project-id",
  "FIREBASE_STORAGE_BUCKET": "replace-with-storage-bucket-if-needed"
}
```
Run:
```bash
flutter pub get
flutter run --dart-define-from-file=firebase.local.json
```
The production auth repository is initialized only when the first four settings are present. With no settings, the app displays **Firebase not configured**, and no Firebase credentials are used.

This repo uses explicit `FirebaseOptions` from compile-time defines rather than a generated `firebase_options.dart`. If the group adopts `flutterfire configure`, consolidate on **one** configuration approach.

## 3. Deploy security rules
Install Firebase CLI, authenticate to the correct account and confirm the chosen project ID:
```bash
firebase login
firebase use --add
firebase deploy --only firestore:rules --project YOUR_PROJECT_ID
```
Check `firebase projects:list` and the console before deploying. Cloud Firestore permissions are mandatory; app UI role controls are **not** a security boundary.

## 4. Provision the first administrator (trusted terminal only)
A signed-in user cannot select their own admin role. Create a normal Firebase Authentication account first, obtain the user's Firebase **UID** through the Firebase Console, and use a trusted, privileged administrator environment:

```bash
npm install --prefix security
node security/provision-admin.cjs YOUR_FIREBASE_AUTH_UID --confirm-admin
```
Requires Application Default Credentials with permission to manage Firebase Auth and Firestore, and `GOOGLE_CLOUD_PROJECT` identifying your exact Firebase project. The script refuses to run without an explicit confirmation flag. Do not run it in public CI or commit credential files.

## 5. Verify actual behavior
- Register student → student profile saved.
- Sign in / sign out and reset email.
- Student requests vendor approval → status becomes pending.
- Admin account reviews pending vendors and approves.
- Vendor gains permission to create listings under Firestore rules.
- Student and anonymous account cannot forge privileged roles.
- Run `npm install --prefix security` and Firebase emulator security tests before deploying rules.

## Notes
- Avoid claiming UM official endorsement until separately authorized.
- For production, improve email verification, abuse prevention, account recovery and deletion flows; use consent and privacy controls.
- Firebase email/password signup is not restricted to `@siswa.um.edu.my` by default; campus eligibility needs separate verification before launch.
- Never use AI to certify food safety.
