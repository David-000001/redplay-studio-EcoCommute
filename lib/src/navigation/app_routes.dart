import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/module_placeholder_screen.dart';

/// Navigation is not authorization: backend permissions are required.
abstract final class AppRoutes {
  static const home = '/';
  static const auth = '/auth';
  static const listings = '/listings';
  static const claims = '/claims';
  static const climate = '/climate';
  static const reports = '/reports';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    final Widget screen = switch (settings.name) {
      home => const HomeScreen(),
      auth => const ModulePlaceholderScreen(title: 'Authentication & Roles', description: 'Owner: Avijit. Pending backend selection and secure role checks.'),
      listings => const ModulePlaceholderScreen(title: 'Surplus Listings', description: 'Owner: HAN YUNUO. Vendor approval and food posting.'),
      claims => const ModulePlaceholderScreen(title: 'Browse, Claim & Collect', description: 'Owners: Maliha and Riptanto. Search and transaction-safe collection.'),
      climate => const ModulePlaceholderScreen(title: 'Climate Awareness', description: 'Owner: Rasha. Climate insights and qualified estimates.'),
      reports => const ModulePlaceholderScreen(title: 'Notifications & Reporting', description: 'Owner: Rasha. Opt-in alerts and protected aggregate reporting.'),
      _ => const ModulePlaceholderScreen(title: 'Page unavailable', description: 'The requested page is undefined.'),
    };
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => screen,
    );
  }
}
