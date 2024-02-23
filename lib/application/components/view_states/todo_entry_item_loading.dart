import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TodoEntryItemLoading extends StatelessWidget {
  const TodoEntryItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Shimmer(
        color: Colors.black,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(''),
        ),
      ),
    );
  }
}
