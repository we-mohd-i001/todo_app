import 'package:either_dart/either.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

class CreateTodoEntry implements UseCase<bool, TodoEntryParams> {
  final TodoRepository todoRepository;

  CreateTodoEntry({required this.todoRepository});

  @override
  Future<Either<Failure, bool>> call(params) async {
    try {
      final result = todoRepository.createTodoEntry(params.entry);
      return result.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
