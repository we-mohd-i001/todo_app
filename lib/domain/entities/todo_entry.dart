import 'package:todo_app/domain/entities/unique_id.dart';

class TodoEntry {
  final String description;
  final bool isDone;
  final EntryId id;

  TodoEntry(
      {required this.description, required this.isDone, required this.id});

  factory TodoEntry.empty() {
    return TodoEntry(description: '', isDone: false, id: EntryId());
  }
}
