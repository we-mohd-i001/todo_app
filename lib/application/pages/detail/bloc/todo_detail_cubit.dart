import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/use_cases/load_todo_entry_ids_for_collection.dart';

part 'todo_detail_state.dart';

class TodoDetailCubit extends Cubit<TodoDetailState> {
  TodoDetailCubit(
      {required this.collectionId, required this.loadTodoEntryIdsForCollection})
      : super(TodoDetailStateLoading());

  final CollectionId collectionId;
  final LoadTodoEntryIdsForCollection loadTodoEntryIdsForCollection;

  Future<void> fetch() async {
    emit(TodoDetailStateLoading());

    try {
      final entryIds = await loadTodoEntryIdsForCollection
          .call(CollectionIdParam(collectionId: collectionId));

      if (entryIds.isLeft) {
        print('entry id isLeft');
        emit(TodoDetailStateError());
      } else {
        emit(TodoDetailStateLoaded(entryIds: entryIds.right));
      }
    } on Exception catch (e) {
      print('Exception');
      emit(TodoDetailStateError());
    }
  }
}
