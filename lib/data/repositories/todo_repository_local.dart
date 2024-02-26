import 'package:either_dart/either.dart';
import 'package:todo_app/data/data_sources/interfaces/todo_local_data_source_interface.dart';
import 'package:todo_app/data/exceptions/exceptions.dart';
import 'package:todo_app/data/models/todo_collection_model.dart';
import 'package:todo_app/data/models/todo_entry_model.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_color.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

class TodoRepositoryLocal extends TodoRepository {
  final TodoLocalDataSourceInterface localDataSource;

  TodoRepositoryLocal({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> createTodoCollection(collection) async {
    try {
      final result = await localDataSource.createTodoCollection(
          collection: todoCollectionToModel(collection));
      return Right(result);
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> createTodoEntry(
      CollectionId collectionId, TodoEntry entry) async {
    try {
      final result = await localDataSource.createTodoEntry(
          collectionId: collectionId.value, entry: todoEntryToModel(entry));
      return Right(result);
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<TodoCollection>>> readTodoCollections() async {
    try {
      final collectionIds = await localDataSource.getTodoCollectionIds();
      final List<TodoCollection> collections = [];
      for (String collectionId in collectionIds) {
        final collection =
            await localDataSource.getTodoCollection(collectionId: collectionId);
        collections.add(todoCollectionModelToEntity(collection));
      }
      return Right(collections);
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> readTodoEntry(
      CollectionId collectionId, EntryId entryId) async {
    try {
      final result = await localDataSource.getTodoEntry(
          collectionId: collectionId.value, entryId: entryId.value);
      return Right(todoEntryModelToEntity(result));
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readTodoEntryIds(
      CollectionId collectionId) async {
    try {
      final entries = await localDataSource.getTodoEntryIds(
          collectionId: collectionId.value);
      return Right(entries.map((id) => EntryId.fromUniqueString(id)).toList());
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> updateTodoEntry(
      {required CollectionId collectionId, required EntryId entryId}) async {
    try {
      final entry = await localDataSource.updateTodoEntry(
          collectionId: collectionId.value, entryId: entryId.value);
      return Right(todoEntryModelToEntity(entry));
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  TodoEntry todoEntryModelToEntity(TodoEntryModel model) {
    final entity = TodoEntry(
        description: model.description,
        isDone: model.isDone,
        id: EntryId.fromUniqueString(model.id));
    return entity;
  }

  TodoCollection todoCollectionModelToEntity(TodoCollectionModel model) {
    final entity = TodoCollection(
        id: CollectionId.fromUniqueString(model.id),
        title: model.title,
        color: TodoColor(colorIndex: model.colorIndex));
    return entity;
  }

  TodoEntryModel todoEntryToModel(TodoEntry entry) {
    final model = TodoEntryModel(
        id: entry.id.value,
        isDone: entry.isDone,
        description: entry.description);
    return model;
  }

  TodoCollectionModel todoCollectionToModel(TodoCollection collection) {
    final model = TodoCollectionModel(
        id: collection.id.value,
        title: collection.title,
        colorIndex: collection.color.colorIndex);
    return model;
  }
}
