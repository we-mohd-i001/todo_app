import 'package:either_dart/either.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

class UpdateTodoEntry implements UseCase<TodoEntry, TodoEntryIdsParam> {
  final TodoRepository todoRepository;

  UpdateTodoEntry({required this.todoRepository});

  @override
  Future<Either<Failure, TodoEntry>> call(TodoEntryIdsParam params) async {
    try {
      final loadedEntry = await todoRepository.updateTodoEntry(
          collectionId: params.collectionId, entryId: params.entryId);
      return loadedEntry.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
