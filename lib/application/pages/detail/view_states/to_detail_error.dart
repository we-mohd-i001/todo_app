import 'package:flutter/material.dart';

class TodoDetailError extends StatelessWidget {
  const TodoDetailError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Text(
        'Error! could not load the details please try again!',
      ),
    );
  }
}
