import 'package:todo_app/data/models/todo_collection_model.dart';
import 'package:todo_app/data/models/todo_entry_model.dart';

abstract class TodoLocalDataSourceInterface {
  Future<TodoEntryModel> getTodoEntry(
      {required String collectionId, required String entryId});

  Future<List<String>> getTodoEntryIds({required String collectionId});

  Future<TodoCollectionModel> getTodoCollection({required String collectionId});

  Future<List<String>> getTodoCollectionIds();

  Future<bool> createTodoEntry(
      {required collectionId, required TodoEntryModel entry});

  Future<bool> createTodoCollection({required TodoCollectionModel collection});

  Future<TodoEntryModel> updateTodoEntry(
      {required String collectionId, required String entryId});
}
