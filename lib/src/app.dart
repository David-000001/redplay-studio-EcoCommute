import 'package:flutter/material.dart';
import 'auth/auth_repository.dart';
import 'navigation/app_routes.dart';

class FoodLoopApp extends StatelessWidget {
  const FoodLoopApp({this.authRepository, this.localDevelopment = false, super.key});

  final AuthRepository? authRepository;
  final bool localDevelopment;

  @override
  Widget build(BuildContext context) {
    final repository = authRepository ?? const UnavailableAuthRepository();
    return MaterialApp(
      title: 'UM FoodLoop',
      debugShowCheckedModeBanner: false,
      builder: (context, child) => localDevelopment
          ? Banner(
              message: 'LOCAL TEST',
              location: BannerLocation.topEnd,
              child: child!,
            )
          : child!,
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
