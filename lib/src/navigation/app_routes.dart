import 'package:flutter/material.dart';

import '../auth/auth_repository.dart';
import '../screens/auth_screen.dart';
import '../screens/home_screen.dart';
import '../screens/module_placeholder_screen.dart';

/// Navigation is never a backend authorization boundary.
abstract final class AppRoutes {
  static const home = '/';
  static const auth = '/auth';
  static const listings = '/listings';
  static const claims = '/claims';
  static const climate = '/climate';
  static const reports = '/reports';

  static Route<void> onGenerateRoute(
    RouteSettings settings, {
    required AuthRepository authRepository,
  }) {
    final Widget screen = switch (settings.name) {
      home => const HomeScreen(),
      auth => AuthScreen(repository: authRepository),
      listings => const ModulePlaceholderScreen(
          title: 'Surplus Listings',
          description: 'Owner: HAN YUNUO. Vendor approval and food posting.',
        ),
      claims => const ModulePlaceholderScreen(
          title: 'Browse, Claim & Collect',
          description: 'Owners: Maliha and Riptanto. Transaction-safe collection.',
        ),
      climate => const ModulePlaceholderScreen(
          title: 'Climate Awareness',
          description: 'Owner: Rasha. Qualified climate insights.',
        ),
      reports => const ModulePlaceholderScreen(
          title: 'Notifications & Reporting',
          description: 'Owner: Rasha. Protected aggregate reporting.',
        ),
      _ => const ModulePlaceholderScreen(
          title: 'Page unavailable',
          description: 'The requested page is undefined.',
        ),
    };
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => screen,
    );
  }
}
