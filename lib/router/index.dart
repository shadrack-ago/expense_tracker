import '../layouts/index.dart';
import '../screens/home.dart';
import '../screens/insights.dart';
import '../screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/add.dart';

class Navigation {
  static GlobalKey<NavigatorState> key = GlobalKey();
  final GoRouter router = GoRouter(
    navigatorKey: key,
    initialLocation: Routes.home.path,
    routes: [
      ShellRoute(
        builder: (context, state, child) => Layout(child: child),
        parentNavigatorKey: key,
        routes: routes
            .map(
              (r) => GoRoute(
                path: r.path,
                name: r.name,
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: r.page,
                  transitionsBuilder: transition,
                  transitionDuration: transitionDuration,
                ),
              ),
            )
            .toList(),
      )
    ],
  );

  static List<_Route> routes = [
    Routes.add,
    Routes.home,
    Routes.insights,
    Routes.settings
  ];

  static RouteTransitionsBuilder transition = (_, animation, __, child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  };

  static Duration transitionDuration = Duration(milliseconds: 250);
}

class Routes {
  static _Route home = _Route(name: Home.id, path: '/${Home.id}', page: Home());
  static _Route insights =
      _Route(name: Insights.id, path: '/${Insights.id}', page: Insights());
  static _Route settings =
      _Route(name: Settings.id, path: '/${Settings.id}', page: Settings());
  static _Route add =
      _Route(name: AddExpense.id, path: '/${AddExpense.id}', page: Insights());
}

class _Route {
  String name;
  String path;
  Widget page;
  _Route({required this.name, required this.path, required this.page});
}
