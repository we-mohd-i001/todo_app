import 'package:either_dart/either.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_color.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

class TodoRepositoryMock implements TodoRepository {
  final List<TodoEntry> todoEntries = List.generate(
      100,
      (index) => TodoEntry(
          description: 'description $index',
          isDone: false,
          id: EntryId.fromUniqueString(index.toString())));
  final todoCollections = List<TodoCollection>.generate(
      10,
      (index) => TodoCollection(
          id: CollectionId.fromUniqueString(index.toString()),
          title: 'title $index',
          color: TodoColor(
              colorIndex: index % TodoColor.predefinedColors.length)));

  @override
  Future<Either<Failure, List<TodoCollection>>> readTodoCollections() {
    try {
      return Future.delayed(
          const Duration(milliseconds: 200), () => Right(todoCollections));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> readTodoEntry(
      CollectionId collectionId, EntryId entryId) {
    try {
      final selectedEntryItem =
          todoEntries.firstWhere((element) => element.id == entryId);
      return Future.delayed(
          const Duration(milliseconds: 200), () => Right(selectedEntryItem));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readTodoEntryIds(
      CollectionId collectionId) {
    try {
      final startIndex = int.parse(collectionId.value) * 10;
      final endIndex = startIndex + 10;
      final entryIds =
          todoEntries.sublist(startIndex, endIndex).map((e) => e.id).toList();

      return Future.delayed(
          const Duration(milliseconds: 300), () => Right(entryIds));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, TodoEntry>> updateTodoEntry(
      {required CollectionId collectionId, required EntryId entryId}) async {
    try {
      final index = todoEntries.indexWhere((element) => element.id == entryId);
      final entryToUpdate = todoEntries[index];
      final updateEntry =
          todoEntries[index].copyWith(isDone: !entryToUpdate.isDone);
      todoEntries[index] = updateEntry;
      return Future.delayed(
          const Duration(milliseconds: 400), () => Right(updateEntry));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
