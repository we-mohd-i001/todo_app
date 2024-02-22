import 'package:either_dart/either.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

class LoadTodoEntry implements UseCase<TodoEntry, TodoEntryIdsParam> {
  LoadTodoEntry({required this.todoRepository});

  final TodoRepository todoRepository;

  @override
  Future<Either<Failure, TodoEntry>> call(params) async {
    try {
      final loadedEntry =
          todoRepository.readTodoEntry(params.collectionId, params.entryId);
      return loadedEntry.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
