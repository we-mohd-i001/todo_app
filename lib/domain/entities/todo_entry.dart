import 'package:equatable/equatable.dart';
import 'package:todo_app/domain/entities/unique_id.dart';

class TodoEntry extends Equatable {
  final String description;
  final bool isDone;
  final EntryId id;

  TodoEntry(
      {required this.description, required this.isDone, required this.id});

  factory TodoEntry.empty() {
    return TodoEntry(description: '', isDone: false, id: EntryId());
  }

  TodoEntry copyWith({String? description, bool? isDone}) {
    return TodoEntry(
        description: description ?? this.description,
        isDone: isDone ?? this.isDone,
        id: id);
  }

  @override
  List<Object> get props => [id, isDone, description];
}
