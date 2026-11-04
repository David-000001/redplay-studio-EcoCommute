# Flutter Android setup

Use [team handoff](team-handoff.md) for the complete local setup, sample accounts, task ownership and review workflow. Use [Firebase setup](firebase-setup.md) for cloud provisioning.

## Commands from repository root
```sh
flutter doctor
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
```
To open the app without a backend: `flutter run`.
To use local Firebase services, start and seed them as described in the handoff, then run `flutter run --dart-define=USE_FIREBASE_EMULATORS=true`.

Navigation test with no cloud connection:
```sh
flutter test integration_test/navigation_test.dart -d emulator-5554
```
With local emulators running and seeded, test the real Dart authentication repository:
```sh
flutter test integration_test/auth_emulator_test.dart -d emulator-5554 --dart-define=USE_FIREBASE_EMULATORS=true
```
Replace the device ID with the Android emulator listed by `flutter devices`. The tests deliberately do not provision or contact a cloud project.

## Troubleshooting
- Missing Android toolchain: resolve `flutter doctor` before building.
- Firebase not configured: local mode requires the compile-time flag; stop and restart after changing flags.
- Connection refused: both emulators must be running on ports 9099 and 8080; Android emulator host is 10.0.2.2.
- Local sign-in fails: run the seed command again, then use the exact local email/password in the handoff.
- Port already in use during security tests: stop the manually running Firebase emulators.
- Permission denied outside profiles: module rules are intentionally unfinished; coordinate with Zhou instead of opening all rules.

## CI
Flutter quality runs analysis and all unit/widget tests. Android checks build a debug APK and run navigation plus local-auth integration tests. Firestore checks run real SDK and rule tests against local emulators. Build artifacts are for development, not a production release.
