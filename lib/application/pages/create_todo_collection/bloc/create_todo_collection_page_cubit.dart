import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_todo_collection_page_state.dart';

class CreateTodoCollectionPageCubit extends Cubit<CreateTodoCollectionPageState> {
  CreateTodoCollectionPageCubit() : super(CreateTodoCollectionPageInitial());
}
