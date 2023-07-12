import 'package:expense_manager/core/provider/manager.dart';
import 'package:provider/provider.dart';

import 'router/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'theme/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DataManager())],
      child: MaterialApp.router(
        title: 'Expense Tracker',
        theme: Theming.theme(context),
        routerConfig: Navigation().router,
      ),
    );
  }
}
