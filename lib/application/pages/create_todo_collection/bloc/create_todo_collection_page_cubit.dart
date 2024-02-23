import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_color.dart';
import 'package:todo_app/domain/use_cases/create_todo_collection.dart';

part 'create_todo_collection_page_state.dart';

class CreateTodoCollectionPageCubit
    extends Cubit<CreateTodoCollectionPageState> {
  final CreateTodoCollection createTodoCollection;
  CreateTodoCollectionPageCubit({required this.createTodoCollection})
      : super(CreateTodoCollectionPageState());
  void titleChanged(String? title) {
    emit(state.copyWith(title: title));
  }

  void colorChanged(String? color) {
    emit(state.copyWith(color: color));
  }

  Future<void> submit() async {
    final parsedColorIndex = int.tryParse(state.color ?? '') ?? 0;
    createTodoCollection.call(TodoCollectionParams(
      collection: TodoCollection.empty().copyWith(
          title: state.title, color: TodoColor(colorIndex: parsedColorIndex)),
    ));
  }
}
