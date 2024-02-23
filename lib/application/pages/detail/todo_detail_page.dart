import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/core/page_config.dart';
import 'package:todo_app/application/pages/detail/bloc/todo_detail_cubit.dart';
import 'package:todo_app/application/pages/detail/view_states/todo_detail_error.dart';
import 'package:todo_app/application/pages/detail/view_states/todo_detail_loaded.dart';
import 'package:todo_app/application/pages/detail/view_states/todo_detail_loading.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';
import 'package:todo_app/domain/use_cases/load_todo_entry_ids_for_collection.dart';

class TodoDetailPageProvider extends StatelessWidget {
  final CollectionId collectionId;
  const TodoDetailPageProvider({super.key, required this.collectionId});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoDetailCubit>(
      create: (context) => TodoDetailCubit(
        collectionId: collectionId,
        loadTodoEntryIdsForCollection: LoadTodoEntryIdsForCollection(
          todoRepository: RepositoryProvider.of<TodoRepository>(context),
        ),
      )..fetch(),
      child: TodoDetailPage(
        collectionId: collectionId,
      ),
    );
  }
}

class TodoDetailPage extends StatelessWidget {
  const TodoDetailPage({super.key, required this.collectionId});
  final CollectionId collectionId;
  static const pageConfig =
      PageConfig(icon: Icons.details, name: 'Details', child: Placeholder());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.7),
            Theme.of(context).primaryColor.withOpacity(0.4),
          ],
        ),
      ),
      child: BlocBuilder<TodoDetailCubit, TodoDetailState>(
          builder: (context, state) {
            bool check = Breakpoints.mediumAndUp == true;
        if (check) {
          context.pop();
        }
        if (state is TodoDetailStateLoading) {
          return const TodoDetailLoading();
        } else if (state is TodoDetailStateLoaded) {
          return TodoDetailLoaded(
              entryIds: state.entryIds, collectionId: collectionId);
        } else {
          return const TodoDetailError();
        }
      }),
    );
  }
}
