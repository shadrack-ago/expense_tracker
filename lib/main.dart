import 'package:expense_manager/core/provider/manager.dart';
import 'package:expense_manager/core/provider/sync.dart';
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
      providers: [
        ChangeNotifierProvider(create: (_) => DataManager()),
        ChangeNotifierProvider(
            create: (_) => SyncManager(
                  docs: 'https://forms.gle/znhV2TDzTXY1zk9p6',
                  sheet:
                      'https://docs.google.com/spreadsheets/d/e/2PACX-1vSGbFtRPwKfGW2rxaWOo8d6zONVIaSTYDbrTRboCNIffzq6bm4bFNof5Rax5Z3QQWepAwZ4tbslEQLY/pubhtml',
                )),
      ],
      child: MaterialApp.router(
        theme: Theming.theme(context),
        routerConfig: Navigation().router,
      ),
    );
  }
}
