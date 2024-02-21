import 'dart:js';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/core/go_router_observer.dart';
import 'package:todo_app/application/pages/home/home_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final routes = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home/dashboard',
    observers: [
      GoRouterObserver()
    ],
    routes: [
      GoRoute(
          path: '/home/settings',
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.amber,
              body: Center(
                child: Container(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => context.push('/home/start'),
                        child: const Text('Go to Start'),
                      ),
                      TextButton(
                          onPressed: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.push('/home/start');
                            }
                          },
                          child: const Text('Go Back'))
                    ],
                  ),
                ),
              ),
            );
          }),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => child,
        routes: [
          GoRoute(
              path: '/home/:tab',
              builder: (context, state) => HomePage(
                    key: state.pageKey,
                    tab: state.pathParameters['tab']!,
                  ))
        ],
      ),
      GoRoute(
          path: '/home/start',
          builder: (context, state) {
            return Container(
              color: Colors.blueGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => context.push('/home/settings'),
                    child: const Text('Go to Settings'),
                  ),
                  TextButton(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.push('/home/settings');
                        }
                      },
                      child: const Text('Go Back'))
                ],
              ),
            );
          }),
    ]);
