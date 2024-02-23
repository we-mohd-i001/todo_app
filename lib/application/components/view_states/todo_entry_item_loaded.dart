import 'package:flutter/material.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';

class TodoEntryItemLoaded extends StatelessWidget {
  final TodoEntry entryItem;
  final Function(bool?) onChanged;

  const TodoEntryItemLoaded(
      {super.key, required this.entryItem, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text(entryItem.description),
        value: entryItem.isDone,
        onChanged: onChanged);
  }
}
