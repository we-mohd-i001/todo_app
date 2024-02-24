import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/core/go_router_observer.dart';
import 'package:todo_app/application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_app/application/pages/create_todo_entry/create_todo_entry_page.dart';
import 'package:todo_app/application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/application/pages/home/bloc/navigation_todo_cubit.dart';
import 'package:todo_app/application/pages/home/home_page.dart';
import 'package:todo_app/application/pages/overview/overview_page.dart';
import 'package:todo_app/application/pages/settings/settings_page.dart';
import 'package:todo_app/domain/entities/unique_id.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

const _basePath = '/start';

final routes = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation:
        '$_basePath/${DashboardPage.pageConfig.name.toLowerCase()}',
    observers: [
      GoRouterObserver()
    ],
    routes: [
      GoRoute(
          name: SettingsPage.pageConfig.name.toLowerCase(),
          path: '$_basePath/${SettingsPage.pageConfig.name.toLowerCase()}',
          builder: (context, state) {
            return const SettingsPage();
          }),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => child,
        routes: [
          GoRoute(
            name: HomePage.pageConfig.name.toLowerCase(),
            path: '$_basePath/:tab',
            builder: (context, state) => HomePage(
              key: state.pageKey,
              tab: state.pathParameters['tab']!,
            ),
          ),
        ],
      ),
      GoRoute(
        name: CreateTodoCollectionPage.pageConfig.name.toLowerCase(),
        path:
            '$_basePath/overview/${CreateTodoCollectionPage.pageConfig.name.toLowerCase()}',
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed(
                    HomePage.pageConfig.name.toLowerCase(),
                    pathParameters: {
                      'tab': OverviewPage.pageConfig.name.toLowerCase()
                    },
                  );
                }
              },
            ),
            title: const Text('Create Todo Collection'),
          ),
          body: SafeArea(
            child: CreateTodoCollectionPage.pageConfig.child,
          ),
        ),
      ),
      GoRoute(
        name: CreateTodoEntryPage.pageConfig.name.toLowerCase(),
        path:
            '$_basePath/overview/${CreateTodoEntryPage.pageConfig.name.toLowerCase()}',
        builder: (context, state) {
          final castedExtra = state.extra as CreateTodoEntryPageExtra;

          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.goNamed(
                      HomePage.pageConfig.name.toLowerCase(),
                      pathParameters: {
                        'tab': OverviewPage.pageConfig.name.toLowerCase()
                      },
                    );
                  }
                },
              ),
              title: const Text('Create Todo Entry'),
            ),
            body: SafeArea(
              child: CreateTodoEntryPageProvider(
                collectionId: castedExtra.collectionsId,
                todoEntryItemCallback: () {
                  castedExtra.todoEntryItemCallback();
                },
              ),
            ),
          );
        },
      ),
      GoRoute(
          name: TodoDetailPage.pageConfig.name.toLowerCase(),
          path: '$_basePath/overview/:collectionId',
          builder: (context, state) {
            return BlocListener<NavigationTodoCubit, NavigationTodoState>(
              listenWhen: (previous, current) =>
                  previous.isSecondaryBodyDisplayed !=
                  current.isSecondaryBodyDisplayed,
              listener: (context, state) {
                if (context.canPop() &&
                    (state.isSecondaryBodyDisplayed ?? false)) {
                  context.pop();
                }
              },
              child: Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.goNamed(
                          HomePage.pageConfig.name.toLowerCase(),
                          pathParameters: {
                            'tab': OverviewPage.pageConfig.name.toLowerCase()
                          },
                        );
                      }
                    },
                  ),
                  title: const Text('Details'),
                ),
                body: Center(
                  child: TodoDetailPageProvider(
                    collectionId: CollectionId.fromUniqueString(
                        state.pathParameters['collectionId'] ?? ''),
                  ),
                ),
              ),
            );
          }),
    ]);
