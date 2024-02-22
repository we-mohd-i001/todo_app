import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/core/page_config.dart';
import 'package:todo_app/application/pages/home/home_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const pageConfig = PageConfig(
      icon: Icons.settings_rounded, name: 'Settings', child: SettingsPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(color: Colors.cyan,)
      ),
    );
  }
}
