import 'package:flutter/material.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';

class TodoOverviewLoaded extends StatelessWidget {
  final List<TodoCollection> collections;

  const TodoOverviewLoaded({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final item = collections[index];
          final colorScheme = Theme.of(context);
          return ListTile(
            tileColor: colorScheme.secondaryHeaderColor,
            selectedTileColor: colorScheme.primaryColor,
            iconColor: item.color.color,
            selectedColor: item.color.color,
            onTap: () => debugPrint(item.title),
            leading: const Icon(Icons.circle),
            title: Text(item.title),
          );
        });
  }
}
