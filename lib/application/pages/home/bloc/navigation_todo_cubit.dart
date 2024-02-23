import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/entities/unique_id.dart';

part 'navigation_todo_state.dart';

class NavigationTodoCubit extends Cubit<NavigationTodoState> {
  NavigationTodoCubit() : super(const NavigationTodoState());

  void selectedTodoCollectionChanged(CollectionId collectionId) {
    emit(NavigationTodoState(selectedCollectionId: collectionId));
  }
}
