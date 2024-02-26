import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/components/todo_entry_item.dart';
import 'package:todo_app/application/pages/create_todo_entry/create_todo_entry_page.dart';
import 'package:todo_app/application/pages/detail/bloc/todo_detail_cubit.dart';
import 'package:todo_app/domain/entities/unique_id.dart';

class TodoDetailLoaded extends StatelessWidget {
  const TodoDetailLoaded(
      {super.key, required this.entryIds, required this.collectionId});

  final List<EntryId> entryIds;
  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            ListView.builder(
              itemCount: entryIds.isEmpty ? 0 : entryIds.length,
              itemBuilder: (context, index) {
                return TodoEntryItemProvider(
                    collectionId: collectionId, entryId: entryIds[index]);
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  key: const Key('create-todo-entry'),
                  heroTag: 'create-todo-entry',
                  onPressed: () {
                    context.pushNamed(
                      CreateTodoEntryPage.pageConfig.name.toLowerCase(),
                      extra: CreateTodoEntryPageExtra(
                        collectionsId: collectionId,
                        todoEntryItemCallback: () {
                          final call = context.read<TodoDetailCubit>().fetch();
                          print('${call}returned the instance for TodoDetailCubit.fetch');

                          return call;
                        },
                      ),
                    );
                  },
                  child: Icon(CreateTodoEntryPage.pageConfig.icon)),
            )
          ],
        ),
      ),
    );
  }
}
