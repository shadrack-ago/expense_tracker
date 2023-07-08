import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Theming {
  static ThemeData theme(BuildContext context) => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showUnselectedLabels: false,
          elevation: 0,
        ),
        navigationRailTheme: NavigationRailThemeData(
          labelType: NavigationRailLabelType.selected,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
          ),
        ),
        listTileTheme: ListTileThemeData(
          leadingAndTrailingTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
      );
}
