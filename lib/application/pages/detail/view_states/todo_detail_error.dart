import 'package:flutter/material.dart';

class TodoDetailError extends StatelessWidget {
  const TodoDetailError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Error! could not load the details please try again!',
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
