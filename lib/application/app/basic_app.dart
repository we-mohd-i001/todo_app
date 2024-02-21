import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
class BasicApp extends StatelessWidget {
  const BasicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Todo App',
      localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,

      ],
    );
  }
}
