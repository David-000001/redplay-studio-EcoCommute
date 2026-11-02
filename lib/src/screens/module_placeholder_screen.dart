import 'package:flutter/material.dart';

class ModulePlaceholderScreen extends StatelessWidget {
  const ModulePlaceholderScreen({
    required this.title,
    required this.description,
    super.key,
  });
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.construction_outlined, size: 48),
        const SizedBox(height: 16),
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(description, textAlign: TextAlign.center),
        const SizedBox(height: 12),
        const Text('Status: Not implemented. This is a navigation placeholder.'),
      ]),
    )),
  );
}
