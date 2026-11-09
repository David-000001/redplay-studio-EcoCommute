# Native Android setup (Java + XML)

Open the repository's **android/** folder in Android Studio. This is now a standalone Gradle Android project; Flutter and Dart are not required. Use an Android Studio version supporting AGP 9.2.1, JDK 21, Android SDK 37 and build-tools 36.0.0. The app runs on Android 7.0/API 24 or newer. Dependency versions are pinned; use the checked-in Gradle 9.4.1 wrapper.

## Local development (recommended for teammates)
1. Install Node.js 22 and JDK 21, and create an Android emulator (API 35 Google APIs works).
2. At the repository root run `npm install --prefix security`, then `npm --prefix security run emulators`.
3. Leave that terminal open; in another run `npm --prefix security run seed`.
4. In Android Studio select the **localDebug** build variant and run on the Android emulator.

From the repository root on Windows:
```powershell
android\gradlew.bat -p android :app:assembleLocalDebug :app:testLocalDebugUnitTest :app:lintLocalDebug
android\gradlew.bat -p android :app:installLocalDebug
```
On macOS/Linux use `./android/gradlew` instead of `android\gradlew.bat`.

Local mode uses a separate `.local` application ID and named Firebase app, fixed project `demo-foodloop-auth`, and host `10.0.2.2` ports 9099/8080. It never uses cloud credentials. It is only available as a debug variant; there is no local release variant. Cleartext is permitted only in local mode. Physical devices are not configured by this guide.

## Existing live development backend
Obtain **google-services.json** from Avijit and save it as **android/app/google-services.json**. It is ignored by Git. Choose **cloudDebug**, sync Gradle and run. Existing cloud users, roles and data are preserved: project `um-foodloop`, package `com.example.um_foodloop`, default Standard Firestore database in Singapore. Do not create another project or register another package.

The old `firebase.local.json` and Flutter `--dart-define` commands no longer configure this app. Never distribute the leader's admin password. Each member should register their own account. With no cloud configuration, the cloud app can display its navigation but account actions are disabled; it never falls back to a local or unrelated project. Release signing is not configured and must be handled separately for a final release.

## Tests
With the Android emulator and seeded Firebase emulators running:
```powershell
android\gradlew.bat -p android :app:connectedLocalDebugAndroidTest
```
The Java tests cover navigation/rotation, account UI sign-in/name editing/sign-out, and native Firebase registration/reset and legacy role compatibility with rejected privilege escalation. The separate Node security suite remains at `security/` and is run with `npm --prefix security run verify` (stop manually running Firebase emulators first).

CI builds a local APK, runs unit tests/lint and Android instrumentation against disposable Firebase emulators. Its `foodloop-native-local-development` artifact contains the APK and reports. No cloud credentials are needed in CI.

## Troubleshooting
- SDK/JDK mismatch: install the pinned SDK and select JDK 21 in Gradle settings.
- Connection refused: start both Firebase emulators and use an Android emulator; `10.0.2.2` points to its host computer.
- Local sign-in fails: seed again and use the exact sample credentials in the handoff.
- Cloud account actions disabled: check the config path, then sync and rebuild cloudDebug.
- Permission denied for unfinished features: coordinate rules/schema with Zhou; never open all database rules.
