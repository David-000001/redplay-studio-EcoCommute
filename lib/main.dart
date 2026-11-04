import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/auth/auth_repository.dart';
import 'src/auth/bootstrap_auth.dart';
import 'src/auth/firebase_environment.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthRepository repository = const UnavailableAuthRepository();

  try {
    repository = await bootstrapAuth();
  } catch (_) {
    repository = const UnavailableAuthRepository();
  }

  runApp(FoodLoopApp(
    authRepository: repository,
    localDevelopment: FirebaseEnvironment.useEmulators,
  ));
}
