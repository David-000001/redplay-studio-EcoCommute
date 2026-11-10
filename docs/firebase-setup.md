# Firebase setup for native Android

The live development project `um-foodloop` is already provisioned: default Standard/native Firestore, Singapore (`asia-southeast1`), Email/Password Auth, deployed rules and owner admin. See [live evidence](live-firebase-verification.md). Do not recreate the project for this migration.

## Android configuration
Use the existing registered app `1:150828310212:android:916bd5ee22a57ad8ba3391`, package `com.example.um_foodloop`. The authorized leader can retrieve its configuration:
```sh
npx -y firebase-tools@latest apps:sdkconfig ANDROID 1:150828310212:android:916bd5ee22a57ad8ba3391 --project um-foodloop --out android/app/google-services.json
```
The config is Git-ignored. Gradle applies the Google Services plugin when present; choose cloudDebug. Follow [Android setup](mobile-setup.md). Local development uses localDebug and requires no cloud config. Legacy `firebase.local.json` is only for the retired Flutter implementation.

## Rules and administrators
The existing profile format and server enforcement are unchanged. Deploy reviewed rules only to the intended project:
```sh
npx -y firebase-tools@latest deploy --only firestore:rules --project um-foodloop
```
The owner administrator already exists; its password remains private. New administrators must be provisioned through trusted Admin SDK tooling in `security/provision-admin.cjs`, never client registration or a role selector. See the script's instructions and existing role rules before changing privileged profiles. Do not include service account keys or tokens in an app or commit.

Zhou owns the private journey schema and access rules in issue #7, with permission and retry tests in #18. The existing rules still implement the old vendor and listing paths. Retire those permissions as part of the reviewed rules migration and verify that legacy profiles can still sign in. Mobility writes require their own tested rules before deployment. The current deployment is a development backend, not approval for a campus launch. Retain only required team records, use synthetic test data and remove it after tests; the leader handles removal requests and project-completion cleanup.
