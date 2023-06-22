import 'package:expense_manager/screens/add.dart';
import 'package:expense_manager/screens/home.dart';
import 'package:expense_manager/screens/insights.dart';
import 'package:expense_manager/screens/settings.dart';
import 'package:flutter/material.dart';

class Navigation {
  static GlobalKey<NavigatorState> router = GlobalKey();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var transition = (_, animation, __, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    };

    switch (settings.name) {
      case Routes.home:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => Home(),
          transitionsBuilder: transition,
          transitionDuration: Duration(milliseconds: 250),
        );
      case Routes.settings:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => Settings(),
          transitionsBuilder: transition,
          transitionDuration: Duration(milliseconds: 250),
        );
      case Routes.insights:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => Insights(),
          transitionsBuilder: transition,
          transitionDuration: Duration(milliseconds: 250),
        );
      case Routes.add:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => AddExpense(),
          transitionsBuilder: transition,
          transitionDuration: Duration(milliseconds: 250),
        );
      default:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => Placeholder(),
          transitionsBuilder: transition,
          transitionDuration: Duration(milliseconds: 250),
        );
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
