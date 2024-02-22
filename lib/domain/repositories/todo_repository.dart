import 'package:either_dart/either.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/failures/failures.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TodoCollection>>> readTodoCollections();

  Future<Either<Failure, TodoEntry>> readTodoEntry(
      CollectionId collectionId, EntryId entryId);
}
