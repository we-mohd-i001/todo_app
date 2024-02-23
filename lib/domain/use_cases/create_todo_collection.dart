import 'package:either_dart/either.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

class CreateTodoCollection implements UseCase<bool, TodoCollectionParams> {
  final TodoRepository todoRepository;

  CreateTodoCollection({required this.todoRepository});

  @override
  Future<Either<Failure, bool>> call(params) async {
    try {
      final result = todoRepository.createTodoCollection(params.collection);
      return result.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
