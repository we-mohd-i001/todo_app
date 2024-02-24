import 'package:either_dart/either.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

class UpdateTodoCollections implements UseCase<List<TodoCollection>, NoParams> {
  final TodoRepository todoRepository;

  UpdateTodoCollections(this.todoRepository);

  @override
  Future<Either<Failure, List<TodoCollection>>> call(NoParams params) async {
    try {
      final loadedCollections = todoRepository.updateTodoCollections();

      return loadedCollections.fold(
              (left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(
        ServerFailure(stackTrace: e.toString()),
      );
    }
  }
}