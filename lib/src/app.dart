import 'package:flutter/material.dart';
import 'auth/auth_repository.dart';
import 'navigation/app_routes.dart';

class FoodLoopApp extends StatelessWidget {
  const FoodLoopApp({this.authRepository, super.key});

  final AuthRepository? authRepository;

  @override
  Widget build(BuildContext context) {
    final repository = authRepository ?? const UnavailableAuthRepository();
    return MaterialApp(
      title: 'UM FoodLoop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF20765A),
        ),
      ),
      initialRoute: AppRoutes.home,
      onGenerateRoute: (settings) =>
          AppRoutes.onGenerateRoute(settings, authRepository: repository),
    );
  }
}
