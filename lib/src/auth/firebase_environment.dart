import 'package:firebase_core/firebase_core.dart';

/// Configure through CI or CLI --dart-define; never hardcode project credentials.
/// Firebase API keys identify projects, but other project settings and passwords
/// must still be protected. No real Firebase project is bundled here.
abstract final class FirebaseEnvironment {
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
