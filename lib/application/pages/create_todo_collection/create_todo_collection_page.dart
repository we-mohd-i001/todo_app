import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application/core/page_config.dart';
import 'package:todo_app/application/pages/create_todo_collection/bloc/create_todo_collection_page_cubit.dart';
import 'package:todo_app/domain/entities/todo_color.dart';

class CreateTodoCollectionPageProvider extends StatelessWidget {
  const CreateTodoCollectionPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreateTodoCollectionPage();
  }
}

class CreateTodoCollectionPage extends StatefulWidget {
  const CreateTodoCollectionPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.add_task_rounded,
    name: 'create_todo_collection',
    child: CreateTodoCollectionPage(),
  );

  @override
  State<CreateTodoCollectionPage> createState() =>
      _CreateTodoCollectionPageState();
}

class _CreateTodoCollectionPageState extends State<CreateTodoCollectionPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) => context
                  .read<CreateTodoCollectionPageCubit>()
                  .titleChanged(value),
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title!';
                }
                return null;
              },
            ),
            TextFormField(
              onChanged: (value) => context
                  .read<CreateTodoCollectionPageCubit>()
                  .colorChanged(value),
              decoration: const InputDecoration(labelText: 'Color'),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final parseColorIndex = int.tryParse(value);
                  if (parseColorIndex == null ||
                      parseColorIndex < 0 ||
                      parseColorIndex > TodoColor.predefinedColors.length) {
                    return 'Only numbers between and ${TodoColor.predefinedColors.length - 1} are allowed';
                  }
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                final isValid = _formKey.currentState?.validate();
                if (isValid == true) {
                  context.read<CreateTodoCollectionPageCubit>().submit();
                  context.pop();
                }
              },
              child: const Text('Save Collection'),
            ),
          ],
        ),
      ),
    );
  }
}
