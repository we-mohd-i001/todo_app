import 'package:either_dart/either.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

class LoadTodoEntryIdsForCollection
    implements UseCase<List<EntryId>, CollectionIdParam> {
  final TodoRepository todoRepository;

  LoadTodoEntryIdsForCollection({required this.todoRepository});

  @override
  Future<Either<Failure, List<EntryId>>> call(params) async {
    try {
      final loadedIds = todoRepository.readTodoEntryIds(params.collectionId);
      print(params.collectionId);
      return loadedIds.fold((left) {
        print('left from LoadTodoEntryIdsForCollection');
        return Left(left);
      }, (right) {
        print('returned right from LoadTodoEntryIdsForCollection call function');
        return Right(right);
      });
    } on Exception catch (e) {
      print('Exception from LoadTodoEntryIdsForCollection');
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
