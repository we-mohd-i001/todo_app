import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/use_cases/load_todo_collections.dart';

part 'todo_overview_state.dart';

class TodoOverviewCubit extends Cubit<TodoOverviewState> {
  TodoOverviewCubit(
      {required this.loadTodoCollections, TodoOverviewState? initialState})
      : super(initialState ?? TodoOverviewStateLoading());

  final LoadTodoCollections loadTodoCollections;

  Future<void> readTodoCollections()async{
    emit(TodoOverviewStateLoading());
    try{
      final collectionsFuture = loadTodoCollections.call(NoParams());
      final collections = await collectionsFuture;
      if(collections.isLeft){
        emit(TodoOverviewStateError());
      } else {
        emit(TodoOverviewStateLoaded(collections: collections.right));
      }
    } on Exception {
      emit(TodoOverviewStateError());
    }
  }
}
