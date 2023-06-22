import 'package:expense_manager/layouts/index.dart';
import 'package:expense_manager/router/index.dart';
import 'package:flutter/material.dart';
import 'theme/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: Theming.theme,
      routerConfig: Navigation().router,
    );
  }
}