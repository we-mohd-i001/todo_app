import 'package:todo_app/data/data_sources/interfaces/todo_local_data_source_interface.dart';
import 'package:todo_app/data/models/todo_collection_model.dart';
import 'package:todo_app/data/models/todo_entry_model.dart';

class HiveLocalDataSource implements TodoLocalDataSourceInterface{
  @override
  Future<bool> createTodoCollection({required TodoCollectionModel collection}) {
    // TODO: implement createTodoCollection
    throw UnimplementedError();
  }

  @override
  Future<bool> createTodoEntry({required String collectionId, required TodoEntryModel entry}) {
    // TODO: implement createTodoEntry
    throw UnimplementedError();
  }

  @override
  Future<TodoCollectionModel> getTodoCollection({required String collectionId}) {
    // TODO: implement getTodoCollection
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getTodoCollectionIds() {
    // TODO: implement getTodoCollectionIds
    throw UnimplementedError();
  }

  @override
  Future<TodoEntryModel> getTodoEntry({required String collectionId, required String entryId}) {
    // TODO: implement getTodoEntry
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getTodoEntryIds({required String collectionId}) {
    // TODO: implement getTodoEntryIds
    throw UnimplementedError();
  }

  @override
  Future<TodoEntryModel> updateTodoEntry({required String collectionId, required String entryId}) {
    // TODO: implement updateTodoEntry
    throw UnimplementedError();
  }
  
}