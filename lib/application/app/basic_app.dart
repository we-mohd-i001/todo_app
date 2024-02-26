import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/application/core/routes.dart';
import 'package:todo_app/application/pages/home/bloc/navigation_todo_cubit.dart';
import 'package:todo_app/application/pages/overview/bloc/todo_overview_cubit.dart';
import 'package:todo_app/application/pages/overview/overview_page.dart';
import 'package:todo_app/domain/use_cases/load_todo_collections.dart';

class BasicApp extends StatelessWidget {
  const BasicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationTodoCubit>(
          create: (context) => NavigationTodoCubit(),
        ),
        BlocProvider(
          create: (context) => TodoOverviewCubit(
            loadTodoCollections:
            LoadTodoCollections(RepositoryProvider.of(context)),
          )..readTodoCollections(),
          child: const OverviewPage(),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        localizationsDelegates: const [
          ...GlobalMaterialLocalizations.delegates,
          GlobalWidgetsLocalizations.delegate,
        ],
        themeMode: ThemeMode.system,
        theme: ThemeData.from(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        darkTheme: ThemeData.from(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        routerConfig: routes,
      ),
    );
  }
}
