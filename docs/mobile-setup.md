# Flutter scaffold setup
The repository contains navigation source, not a complete running Android project. Flutter and platform files are required; SDK compilation has not been verified in this environment.

## Setup
```bash
flutter doctor
flutter create . --platforms=android
flutter pub get
flutter analyze
flutter test
flutter run
```
Inspect changes made by `flutter create` before committing generated Android files.

## Architecture
- `lib/main.dart`: entrypoint
- `lib/src/app.dart`: theme and route registry
- `lib/src/navigation/app_routes.dart`: navigation only; **not authorization**
- `lib/src/screens/`: home and explicit not-implemented module placeholders
- `test/app_test.dart`: widget smoke tests

## Next: #9 authentication
After the group confirms backend technology and creates an authorized backend project, implement sign-in, logout, password recovery and backend-enforced student/vendor/admin roles. Do not grant admin permissions from a UI control, and never commit service keys.
