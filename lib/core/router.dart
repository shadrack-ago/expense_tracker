import 'package:expense_manager/screens/home.dart';
import 'package:flutter/material.dart';

class Navigation {
  static GlobalKey<NavigatorState> router = GlobalKey();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Home());
      default:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Placeholder());
    }
  }

  static Navigator navigator = Navigator(
    key: Navigation.router,
    initialRoute: Routes.home,
    onGenerateRoute: Navigation.generateRoute,
  );
}

class Routes {
  static const String home = Home.id;
}
