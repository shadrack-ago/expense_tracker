import 'package:expense_manager/core/layouts.dart';
import 'package:flutter/material.dart';
import 'core/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theming.theme,
      home: Layout(),
    );
  }
}