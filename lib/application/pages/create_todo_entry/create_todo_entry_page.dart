import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/core/form_value.dart';
import 'package:todo_app/application/core/page_config.dart';
import 'package:todo_app/application/pages/create_todo_entry/bloc/create_todo_entry_page_cubit.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';
import 'package:todo_app/domain/use_cases/create_todo_entry.dart';

class CreateTodoEntryPageProvider extends StatelessWidget {
  final CollectionId collectionId;
  const CreateTodoEntryPageProvider({super.key, required this.collectionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTodoEntryPageCubit>(
      create: (context) => CreateTodoEntryPageCubit(
        collectionId: collectionId,
        addTodoEntry: CreateTodoEntry(
          todoRepository: RepositoryProvider.of<TodoRepository>(context),
        ),
      ),
      child: const CreateTodoEntryPage(),
    );
  }
}

class CreateTodoEntryPage extends StatefulWidget {
  const CreateTodoEntryPage({super.key});

  static const pageConfig = PageConfig(
      icon: Icons.add_circle_rounded,
      name: 'create_todo_entry',
      child: Placeholder());

  @override
  State<CreateTodoEntryPage> createState() => _CreateTodoEntryPageState();
}

class _CreateTodoEntryPageState extends State<CreateTodoEntryPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                final currentValidationState = context
                    .read<CreateTodoEntryPageCubit>()
                    .descriptionChanged(description: value);
              },
              validator: (value) {
                final currentValidationState = context
                        .read<CreateTodoEntryPageCubit>()
                        .state
                        .description
                        ?.validationStatus ??
                    ValidationStatus.pending;
                switch (currentValidationState) {
                  case ValidationStatus.error:
                    return 'This field needs at-least two characters';
                  case ValidationStatus.success:
                  case ValidationStatus.pending:
                    return null;
                }
              },
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                final isValid = _formKey.currentState?.validate();
                if (isValid == true) {
                  context.read<CreateTodoEntryPageCubit>().submit();
                  context.pop();
                }
              },
              child: const Text('Save Entry'),
            ),
          ],
        ),
      ),
    );
  }
}
