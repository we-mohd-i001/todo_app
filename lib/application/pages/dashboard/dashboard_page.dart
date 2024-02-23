import 'package:flutter/material.dart';
import 'package:todo_app/application/core/page_config.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const pageConfig = PageConfig(
      icon: Icons.dashboard_rounded, name: 'Dashboard', child: DashboardPage());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      child: const Center(
        child: Card(
          color: Colors.cyanAccent,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('The Dashboard'),
          ),
        ),
      ),
    );
  }
}
