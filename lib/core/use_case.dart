import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
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

class CollectionIdParam extends Params {
  final CollectionId collectionId;

  CollectionIdParam({required this.collectionId}) : super();

  @override
  List<Object> get props => [collectionId];
}

class TodoCollectionParams extends Params {
  final TodoCollection collection;

  TodoCollectionParams({required this.collection}) : super();

  @override
  List<Object> get props => [collection];
}

class TodoEntryParams extends Params{
  final TodoEntry entry;

  TodoEntryParams({required this.entry}) : super();

  @override
  List<Object> get props => [entry];



}