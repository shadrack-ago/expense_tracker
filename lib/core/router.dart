import 'package:flutter/material.dart';

class Navigation {
  static GlobalKey<NavigatorState> router = GlobalKey();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Placeholder());
    }
  }
}
