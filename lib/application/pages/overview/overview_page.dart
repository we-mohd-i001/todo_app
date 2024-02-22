import 'package:flutter/material.dart';
import 'package:todo_app/application/core/page_config.dart';
import 'package:todo_app/application/pages/overview/view_states/todo_overview_loaded.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  static const pageConfig = PageConfig(
      icon: Icons.work_history_rounded, name: 'Overview', child: OverviewPage());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const TodoOverviewLoaded(collections: [],),
    );
  }
}
