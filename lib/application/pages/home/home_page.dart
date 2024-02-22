import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/core/page_config.dart';
import 'package:todo_app/application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/application/pages/overview/overview_page.dart';
import 'package:todo_app/application/pages/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required String tab,
    // int? index
  }) : index = tabs.indexWhere((element) => element.name.toLowerCase() == tab);
  static const PageConfig pageConfig = PageConfig(
    icon: Icons.home,
    name: 'Home',
  );
  final int index;

  static const tabs = [
    DashboardPage.pageConfig,
    OverviewPage.pageConfig,
    SettingsPage.pageConfig,
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final destinations = HomePage.tabs.map(
      (page) => NavigationDestination(icon: Icon(page.icon), label: page.name));
  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      //backgroundColor: themeData.focusColor,
      body: SafeArea(
        child: AdaptiveLayout(
            primaryNavigation: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.mediumAndUp: SlotLayout.from(
                  key: const Key('primary-navigation-medium'),
                  builder: (context) => AdaptiveScaffold.standardNavigationRail(
                    selectedIndex: widget.index,
                    selectedLabelTextStyle:
                        TextStyle(color: themeData.colorScheme.primary),
                    selectedIconTheme:
                        IconThemeData(color: themeData.colorScheme.primary),
                    unselectedIconTheme: IconThemeData(
                        color: themeData.colorScheme.primary.withOpacity(0.5)),
                    onDestinationSelected: (index) {
                      debugPrint('tap $index selected');
                      _tapOnNavigationDestination(context, index);
                    },
                    destinations: destinations
                        .map(
                          (_) => AdaptiveScaffold.toRailDestination(_),
                        )
                        .toList(),
                  ),
                )
              },
            ),
            bottomNavigation: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.small: SlotLayout.from(
                  key: const Key('bottom-navigation-small'),
                  builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
                      destinations: destinations.toList(),
                      currentIndex: widget.index,
                      onDestinationSelected: (value) =>
                          _tapOnNavigationDestination(context, value)),
                ),
              },
            ),
            body: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.smallAndUp: SlotLayout.from(
                    key: const Key('primary-body-small'),
                    builder: (_) => HomePage.tabs[widget.index].child)
              },
            ),
            secondaryBody: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('secondary-body-medium'),
                builder: (_) => Placeholder(),
              )
            })),
      ),
    );
  }

  void _tapOnNavigationDestination(BuildContext context, int index) {
    context.goNamed(HomePage.pageConfig.name.toLowerCase(),
        pathParameters: {'tab': HomePage.tabs[index].name.toLowerCase()});
  }
}