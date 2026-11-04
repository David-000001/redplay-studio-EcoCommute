import 'package:firebase_core/firebase_core.dart';

/// Configure through CI or CLI --dart-define; never hardcode project credentials.
/// Firebase API keys identify projects, but other project settings and passwords
/// must still be protected. No real Firebase project is bundled here.
abstract final class FirebaseEnvironment {
  static const useEmulators = bool.fromEnvironment('USE_FIREBASE_EMULATORS');
  static const emulatorHost = String.fromEnvironment(
    'FIREBASE_EMULATOR_HOST',
    defaultValue: '10.0.2.2',
  );
  static const demoProjectId = 'demo-foodloop-auth';

  static const emulatorOptions = FirebaseOptions(
    apiKey: 'demo-only-not-a-real-firebase-key',
    appId: '1:1234567890:android:1234567890abcdef',
    messagingSenderId: '1234567890',
    projectId: demoProjectId,
  );
  static const apiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const appId = String.fromEnvironment('FIREBASE_APP_ID');
  static const messagingSenderId =
      String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');
  static const projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
  static const storageBucket =
      String.fromEnvironment('FIREBASE_STORAGE_BUCKET');

  static bool get isConfigured =>
      apiKey.isNotEmpty &&
      appId.isNotEmpty &&
      messagingSenderId.isNotEmpty &&
      projectId.isNotEmpty;

  static FirebaseOptions get androidOptions => const FirebaseOptions(
        apiKey: apiKey,
        appId: appId,
        messagingSenderId: messagingSenderId,
        projectId: projectId,
        storageBucket: storageBucket,
      );
}
