import 'package:easy_web_view/easy_web_view.dart';
import 'package:expense_manager/layouts/index.dart';
import 'package:flutter/material.dart';

class Insights extends StatelessWidget {
  const Insights({super.key});

  static const String id = 'insights';

  List<Widget> get graphs {
    return [
      Expanded(
          child: Card(child: Column(children: [Text('Expenditure habits')]))),
      Expanded(child: Card(child: Column(children: [Text('Saving habits')])))
    ];
  }


  static ValueKey webViewKey = const ValueKey('key_0');

  final String src =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vSGbFtRPwKfGW2rxaWOo8d6zONVIaSTYDbrTRboCNIffzq6bm4bFNof5Rax5Z3QQWepAwZ4tbslEQLY/pubhtml';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Breakdown',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        Expanded(
          flex: 1,
          child: Breakpoints.of(context).isMobile()
              ? Column(
                  children: graphs,
                )
              : Row(children: graphs),
        ),
        SizedBox(height: 10),
        Text(
          'Spreadsheet',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        Expanded(
          flex: 2,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: EasyWebView(
                key: webViewKey,
                src: src,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
