import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application/components/bloc/todo_entry_item_cubit.dart';
import 'package:todo_app/application/components/view_states/todo_entry_item_error.dart';
import 'package:todo_app/application/components/view_states/todo_entry_item_loaded.dart';
import 'package:todo_app/application/components/view_states/todo_entry_item_loading.dart';
import 'package:todo_app/application/pages/detail/bloc/todo_detail_cubit.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';
import 'package:todo_app/domain/use_cases/load_todo_entry.dart';

class TodoEntryItemProvider extends StatelessWidget {
  final CollectionId collectionId;
  final EntryId entryId;
  const TodoEntryItemProvider(
      {super.key, required this.collectionId, required this.entryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoEntryItemCubit>(
      create: (context) => TodoEntryItemCubit(
        collectionId: collectionId,
        loadTodoEntry: LoadTodoEntry(
          todoRepository: RepositoryProvider.of<TodoRepository>(context),
        ),
        entryId: entryId,
      )..fetch(),
      child: const TodoEntryItem(),
    );
  }
}

class TodoEntryItem extends StatelessWidget {
  const TodoEntryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEntryItemCubit, TodoEntryItemState>(
        builder: (context, state) {
          if(state is TodoEntryItemStateLoading){
            return TodoEntryItemLoading();
          }
          else if(state is TodoEntryItemStateLoaded){
            return TodoEntryItemLoaded(
              entryItem: state.todoEntry,
            );
          }
          else{
            return TodoEntryItemError();
          }
        });
  }
}
