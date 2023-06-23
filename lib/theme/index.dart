import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Theming {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.green,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showUnselectedLabels: false,
          elevation: 0,
        ),
        navigationRailTheme: NavigationRailThemeData(
          labelType: NavigationRailLabelType.selected,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
    
  );
}
