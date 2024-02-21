import 'package:flutter/material.dart';

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint('didPop: ${route.settings.name}');
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint('didPush: ${route.settings.name} previousRoute: ${previousRoute
        ?.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    debugPrint('didRemove: ${route.settings.name} previousRoute: ${previousRoute
        ?.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    debugPrint('didReplace: ${newRoute?.settings.name} oldRoute: ${oldRoute?.settings.name}');
  }

}
