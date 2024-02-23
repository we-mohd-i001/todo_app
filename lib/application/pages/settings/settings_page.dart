import 'package:flutter/material.dart';
import 'package:todo_app/application/core/page_config.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const pageConfig = PageConfig(
      icon: Icons.settings_rounded, name: 'Settings', child: SettingsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Please Hot Restart!'),
        ),
      ),
    );
  }
}
