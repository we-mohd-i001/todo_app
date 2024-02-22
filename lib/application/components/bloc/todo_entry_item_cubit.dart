import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/use_cases/load_todo_entry.dart';

part 'todo_entry_item_state.dart';

class TodoEntryItemCubit extends Cubit<TodoEntryItemState> {
  final EntryId entryId;
  final CollectionId collectionId;
  final LoadTodoEntry loadTodoEntry;
  // final UpdateTodoEntry updateTodoEntry;
  TodoEntryItemCubit({
    required this.entryId,
    required this.collectionId,
    required this.loadTodoEntry,
  }) : super(TodoEntryItemStateLoading());

  Future<void> fetch() async {
    try {
      final entry = await loadTodoEntry.call(
        TodoEntryIdsParam(collectionId: collectionId, entryId: entryId),
      );
      return entry.fold(
        (left) => emit(TodoEntryItemStateError()),
        (right) => emit(
          TodoEntryItemStateLoaded(todoEntry: right),
        ),
      );
    } on Exception catch (e) {
      return emit(TodoEntryItemStateError());
    }
  }

  Future<void> update() async {
    throw UnimplementedError();
  }
}
