import 'package:flutter/material.dart';
import 'package:todo_app/application/components/view_states/todo_entry_item.dart';
import 'package:todo_app/domain/entities/unique_id.dart';

class TodoDetailLoaded extends StatelessWidget {
  const TodoDetailLoaded(
      {super.key, required this.entryIds, required this.collectionId});

  final List<EntryId> entryIds;
  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: entryIds.length,
            itemBuilder: (context, index) {
              return TodoEntryItemProvider(
                  collectionId: collectionId, entryId: entryIds[index]);
            }),
      ),
    );
  }
}
