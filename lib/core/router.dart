import 'package:expense_manager/screens/add.dart';
import 'package:expense_manager/screens/home.dart';
import 'package:expense_manager/screens/insights.dart';
import 'package:expense_manager/screens/settings.dart';
import 'package:flutter/material.dart';

class Navigation {
  static GlobalKey<NavigatorState> router = GlobalKey();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return PageRouteBuilder(
            settings: settings, pageBuilder: (_, __, ___) => Home());
      case Routes.settings:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Settings());
      case Routes.insights:
        return PageRouteBuilder(
            settings: settings, pageBuilder: (_, __, ___) => Insights());
      case Routes.add:
        return PageRouteBuilder(
            settings: settings, pageBuilder: (_, __, ___) => AddExpense());
      default:
        return PageRouteBuilder(
            settings: settings, pageBuilder: (_, __, ___) => Placeholder());
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
  static const String insights = Insights.id;
  static const String settings = Settings.id;
  static const String add = AddExpense.id;
}
