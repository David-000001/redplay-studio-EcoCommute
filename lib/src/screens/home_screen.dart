import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const modules = <({String title, String route, IconData icon})>[
    (title: 'Authentication & Roles', route: AppRoutes.auth, icon: Icons.lock_outline),
    (title: 'Surplus Listings', route: AppRoutes.listings, icon: Icons.restaurant_outlined),
    (title: 'Browse, Claim & Collect', route: AppRoutes.claims, icon: Icons.shopping_bag_outlined),
    (title: 'Climate Awareness', route: AppRoutes.climate, icon: Icons.eco_outlined),
    (title: 'Notifications & Reporting', route: AppRoutes.reports, icon: Icons.analytics_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UM FoodLoop')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('RedPlay Studio', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            const Text('WIA2007 • Tutorial Group 9 • SDG 13.3 (pending approval)'),
            const SizedBox(height: 12),
            const Card(child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Development scaffold only: no real accounts, claims or food safety verification are active.'),
            )),
            for (final module in modules)
              Card(child: ListTile(
                leading: Icon(module.icon),
                title: Text(module.title),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).pushNamed(module.route),
              )),
          ],
        ),
      ),
    );
  }
}
