import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application/core/page_config.dart';
import 'package:todo_app/application/pages/overview/bloc/todo_overview_cubit.dart';
import 'package:todo_app/application/pages/overview/view_states/todo_overview_error.dart';
import 'package:todo_app/application/pages/overview/view_states/todo_overview_loaded.dart';
import 'package:todo_app/application/pages/overview/view_states/todo_overview_loading.dart';
import 'package:todo_app/domain/use_cases/load_todo_collections.dart';

class OverViewPageProvider extends StatelessWidget {
  const OverViewPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (context) => TodoOverviewCubit(
        loadTodoCollections:
            LoadTodoCollections(RepositoryProvider.of(context)),
      )..readTodoCollections(),
      child: const OverviewPage(),
    );
  }
}

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  static const pageConfig = PageConfig(
      icon: Icons.work_history_rounded,
      name: 'Overview',
      child: OverViewPageProvider());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
            Theme.of(context).primaryColor.withOpacity(0.4),
            Theme.of(context).primaryColor.withOpacity(0.2)
          ])),
      child: BlocBuilder<TodoOverviewCubit, TodoOverviewState>(
          builder: (context, state) {
        if (state is TodoOverviewStateLoading) {
          return const Center(child: TodoOverviewLoading());
        } else if (state is TodoOverviewStateLoaded) {
          return TodoOverviewLoaded(collections: state.collections);
        } else {
          return const TodoOverviewError();
        }
      }),
    );
  }
}
