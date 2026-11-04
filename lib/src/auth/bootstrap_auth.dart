import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'auth_repository.dart';
import 'firebase_auth_repository.dart';
import 'firebase_environment.dart';

/// Connect both services before exposing a repository to any screen.
Future<AuthRepository> bootstrapAuth() async {
  final local = FirebaseEnvironment.useEmulators;
  if (local && !kDebugMode) {
    throw StateError('Firebase emulators are allowed only in debug builds.');
  }
  if (!local && !FirebaseEnvironment.isConfigured) {
    return const UnavailableAuthRepository();
  }
  await Firebase.initializeApp(
    options: local
        ? FirebaseEnvironment.emulatorOptions
        : FirebaseEnvironment.androidOptions,
  );
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  if (local) {
    // A fixed demo project prevents accidental use of cloud resources.
    await auth.useAuthEmulator(FirebaseEnvironment.emulatorHost, 9099);
    db.useFirestoreEmulator(FirebaseEnvironment.emulatorHost, 8080);
    db.settings = const Settings(persistenceEnabled: false);
  }
  return FirebaseAuthRepository(auth: auth, firestore: db);
}
