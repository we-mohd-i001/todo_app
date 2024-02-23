import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/application/pages/home/bloc/navigation_todo_cubit.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';

class TodoOverviewLoaded extends StatelessWidget {
  final List<TodoCollection> collections;

  const TodoOverviewLoaded({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final item = collections[index];
          final colorScheme = Theme.of(context);
          return ListTile(
            selectedTileColor: colorScheme.primaryColor,
            iconColor: item.color.color,
            selectedColor: item.color.color,
            onTap: () {
              context.read<NavigationTodoCubit>().selectedTodoCollectionChanged(item.id);
              if (Breakpoints.small.isActive(context)) {
                context.pushNamed(
                  TodoDetailPage.pageConfig.name.toLowerCase(),
                  pathParameters: {'collectionId': item.id.value},
                );
              }
            },
            leading: const Icon(Icons.circle),
            title: Text(item.title),
          );
        });
  }
}
