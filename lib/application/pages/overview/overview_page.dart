import 'package:flutter/material.dart';
import 'package:todo_app/application/core/page_config.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  static const pageConfig = PageConfig(
      icon: Icons.work_history_rounded, name: 'Overview', child: OverviewPage());

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
