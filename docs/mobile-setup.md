# Flutter Android setup and testing

## Project status (2 Nov 2026)
- **Native Android project exists** in `android/`, generated with `flutter create . --platforms=android --project-name um_foodloop` on GitHub Actions.
- Flutter SDK installation, `flutter analyze` and the existing widget tests **passed** in GitHub Actions.
- `flutter build apk --debug` **passed**, and an Android API 35 emulator booted and installed the app in the bootstrap job.
- **Android API 35 emulator integration test PASSED** on the corrected test: home → Authentication → back → Surplus Listings. Verified in [GitHub Actions run #41415696320](https://github.com/David-000001/redplay-studio-foodloop/actions/runs/41415696320). The prior assertion failure was diagnosed and corrected.
- **Debug APK artifact uploaded** in the same successful workflow (artifact name: `foodloop-android-debug-apk`); download from the run's Artifacts section.

## Run locally
1. Install the Flutter SDK, Android Studio / Android SDK and a compatible JDK.
2. Clone this repository.
3. Run:
```bash
flutter doctor
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
flutter devices
flutter run
```
4. To execute a navigation integration test on a connected Android emulator:
```bash
flutter test integration_test/navigation_test.dart -d emulator-5554
```
Use the emulator device ID shown by `flutter devices`.

## Source tree
- `lib/main.dart`: app entrypoint.
- `lib/src/app.dart`: Material app and theme.
- `lib/src/navigation/app_routes.dart`: route names; navigation is **not** backend authorization.
- `lib/src/screens/`: home page and explicit placeholder screens.
- `test/app_test.dart`: widget smoke tests.
- `integration_test/navigation_test.dart`: real Android navigation test.
- `android/`: generated native Android project.
- `.github/workflows/checks.yml`: analyzer and widget checks.
- `.github/workflows/android-smoke.yml`: Android emulator navigation test.
- `.github/workflows/bootstrap-android.yml`: original Android platform bootstrapping and debug build job.

## Next issue (#9): authentication
Once the backend is approved and provisioned, implement student/vendor login, password recovery, controlled vendor approval and backend-enforced admin roles. The placeholder at `/auth` does not authenticate users. Never commit credentials, API secrets or personal student data.
