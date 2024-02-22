import 'package:flutter/material.dart';

class TodoOverviewError extends StatelessWidget {
  const TodoOverviewError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Text('ERROR, please try again!'),
    );
  }
}
