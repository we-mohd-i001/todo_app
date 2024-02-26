<<<<<<< HEAD
=======
import 'dart:html';

>>>>>>> add_local_data_source
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/data_sources/interfaces/todo_local_data_source_interface.dart';
import 'package:todo_app/data/exceptions/exceptions.dart';
import 'package:todo_app/data/models/todo_collection_model.dart';
import 'package:todo_app/data/models/todo_entry_model.dart';

class HiveLocalDataSource implements TodoLocalDataSourceInterface {
  late BoxCollection todoCollection;

  bool isInitialized = false;

  Future<void> init() async {
    if (!isInitialized) {
      todoCollection = await BoxCollection.open(
        'todo',
        {'collection', 'entry'},
        path: './',
      );

      isInitialized = true;
    } else {
      debugPrint('Hive was already initialized.');
    }
  }

  Future<CollectionBox<Map>> _openCollectionBox() async {
    return todoCollection.openBox<Map>('collection');
  }

  Future<CollectionBox<Map>> _openEntryBox() async {
    return todoCollection.openBox<Map>('entry');
  }

  @override
  Future<bool> createTodoCollection(
      {required TodoCollectionModel collection}) async {
    final collectionBox = await _openCollectionBox();
    final entryBox = await _openEntryBox();

    await collectionBox.put(collection.id, collection.toJson());
    await entryBox.put(collection.id, {});
    return true;
  }

  @override
  Future<bool> createTodoEntry(
      {required String collectionId, required TodoEntryModel entry}) async {
    final entryBox = await _openEntryBox();
    final entryList = await entryBox.get(collectionId);
    if (entryList == null) throw CollectionNotFoundException();
    entryList
        .cast<String, dynamic>()
        .putIfAbsent(entry.id, () => entry.toJson());
    await entryBox.put(collectionId, entryList);
    return true;
  }

  @override
  Future<TodoCollectionModel> getTodoCollection(
      {required String collectionId}) async {
    final collectionBox = await _openCollectionBox();
    final collection =
<<<<<<< HEAD
        (await collectionBox.get(collectionId))?.cast<String, dynamic>();
=======
        (await collectionBox.get(collectionId)) as Map<String, dynamic>?;
>>>>>>> add_local_data_source
    if (collection == null) throw EntryNotFoundException();
    final todoCollectionModel = TodoCollectionModel.fromJson(collection);
    return todoCollectionModel;
  }

  @override
  Future<List<String>> getTodoCollectionIds() async {
    final collectionBox = await _openCollectionBox();
    final collectionIdList = await collectionBox.getAllKeys();

    return collectionIdList;
  }

  @override
  Future<TodoEntryModel> getTodoEntry(
      {required String collectionId, required String entryId}) async {
    final entryBox = await _openEntryBox();
    final entryIdList = await entryBox.get(collectionId);

    if (entryIdList == null) {
      throw CollectionNotFoundException();
    }
    if (!entryIdList.containsKey(entryId)) throw EntryNotFoundException();
    final entry = entryIdList[entryId].cast<String, dynamic>();

    return TodoEntryModel.fromJson(entry);
  }

  @override
  Future<List<String>> getTodoEntryIds({required String collectionId}) async {
    final entryBox = await _openEntryBox();
    final entryList = await entryBox.get(collectionId);

    if (entryList == null) {
      throw CollectionNotFoundException();
    }
    final entryIdList = entryList.cast<String, dynamic>().keys.toList();

    return entryIdList;
  }

  @override
  Future<TodoEntryModel> updateTodoEntry(
      {required String collectionId, required String entryId}) async {
    final entryBox = await _openEntryBox();
    final entryList = await entryBox.get(collectionId);

    if (entryList == null) {
      throw CollectionNotFoundException();
    }
    if (!entryList.containsKey(entryId)) throw EntryNotFoundException();

    final entry =
        TodoEntryModel.fromJson(entryList[entryId].cast<String, dynamic>());

    final updatedEntry = TodoEntryModel(
        id: entry.id, isDone: !entry.isDone, description: entry.description);
    entryList[entryId] = updatedEntry.toJson();

    await entryBox.put(collectionId, entryList);

    return updatedEntry;
  }
}
