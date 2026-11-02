import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/auth/auth_repository.dart';
import 'src/auth/firebase_auth_repository.dart';
import 'src/auth/firebase_environment.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthRepository repository = const UnavailableAuthRepository();

  if (FirebaseEnvironment.isConfigured) {
    try {
      await Firebase.initializeApp(
        options: FirebaseEnvironment.androidOptions,
      );
      repository = FirebaseAuthRepository(
        auth: FirebaseAuth.instance,
        firestore: FirebaseFirestore.instance,
      );
    } catch (_) {
      // Fail closed when project configuration is missing or invalid.
      repository = const UnavailableAuthRepository();
    }
  }

  runApp(FoodLoopApp(authRepository: repository));
}
