import 'package:either_dart/either.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_color.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

class TodoRepositoryMock implements TodoRepository {
  @override
  Future<Either<Failure, List<TodoCollection>>> readTodoCollections() {
    final list = List<TodoCollection>.generate(
        10,
        (index) => TodoCollection(
            id: CollectionId.fromUniqueString(index.toString()),
            title: 'title $index',
            color: TodoColor(
                colorIndex: index % TodoColor.predefinedColors.length)));

    return Future.delayed(const Duration(milliseconds: 200), () => Right(list));
  }

  @override
  Future<Either<Failure, TodoEntry>> readTodoEntry(CollectionId collectionId, EntryId entryId) {
    // TODO: implement readTodoEntry
    throw UnimplementedError();
  }
}
