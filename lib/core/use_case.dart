import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/failures/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class Params extends Equatable {}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodoEntryIdsParam extends Params {
  final CollectionId collectionId;
  final EntryId entryId;

  TodoEntryIdsParam({required this.collectionId, required this.entryId})
      : super();

  @override
  List<Object> get props => [collectionId, entryId];
}
