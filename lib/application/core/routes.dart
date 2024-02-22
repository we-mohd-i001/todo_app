import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/core/go_router_observer.dart';
import 'package:todo_app/application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/application/pages/home/home_page.dart';
import 'package:todo_app/application/pages/settings/settings_page.dart';

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
                  ))
        ],
      ),
    ]);
