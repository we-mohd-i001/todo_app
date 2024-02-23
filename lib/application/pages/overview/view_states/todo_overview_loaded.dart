import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_app/application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/application/pages/home/bloc/navigation_todo_cubit.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';

class TodoOverviewLoaded extends StatelessWidget {
  final List<TodoCollection> collections;

  const TodoOverviewLoaded({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<NavigationTodoCubit, NavigationTodoState>(
            buildWhen: (previous, current) =>
                previous.selectedCollectionId != current.selectedCollectionId,
            builder: (context, state) {
              return ListView.builder(
                itemCount: collections.length,
                itemBuilder: (context, index) {
                  final item = collections[index];
                  final colorScheme = Theme.of(context);
                  return ListTile(
                    selectedTileColor: colorScheme.secondaryHeaderColor,
                    iconColor: item.color.color,
                    selectedColor: item.color.color,
                    selected: state.selectedCollectionId == item.id,
                    onTap: () {
                      context
                          .read<NavigationTodoCubit>()
                          .selectedTodoCollectionChanged(item.id);
                      if (Breakpoints.small.isActive(context)) {
                        context.pushNamed(
                          TodoDetailPage.pageConfig.name.toLowerCase(),
                          pathParameters: {'collectionId': item.id.value},
                        );
                      }
                    },
                    leading: const Icon(Icons.circle),
                    title: Text(
                      item.title,
                      style: colorScheme.textTheme.titleMedium,
                    ),
                  );
                },
              );
            }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton.icon(
              onPressed: () {
                context.pushNamed(
                    CreateTodoCollectionPage.pageConfig.name.toString());
              },
              icon: Icon(
                CreateTodoCollectionPage.pageConfig.icon,
              ),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Add Collection'),
              ),
              //child: Icon(CreateTodoCollectionPage.pageConfig.icon),
            ),
          ),
        ),
      ],
    );
  }
}
