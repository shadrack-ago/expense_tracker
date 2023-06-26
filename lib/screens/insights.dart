import 'package:easy_web_view/easy_web_view.dart';
import 'package:expense_manager/layouts/index.dart';
import 'package:flutter/material.dart';

class Insights extends StatelessWidget {
  const Insights({super.key});

  static const String id = 'insights';

  static ValueKey webViewKey = const ValueKey('key_0');

  final String src =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vSGbFtRPwKfGW2rxaWOo8d6zONVIaSTYDbrTRboCNIffzq6bm4bFNof5Rax5Z3QQWepAwZ4tbslEQLY/pubhtml';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Breakdown',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Breakpoints.of(context).isMobile()
              ? Column(
                  children: [
                    Card(
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: Column(children: [Text('Expenditure habits')]),
                      ),
                    ),
                    Card(
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: Column(children: [Text('Saving habits')]),
                      ),
                    ),
                  ],
                )
              : Row(children: [
                  Expanded(
                    child: Card(
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: Column(children: [Text('Expenditure habits')]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: Column(children: [Text('Saving habits')]),
                      ),
                    ),
                  ),
                ]),
          SizedBox(height: 10),
          Text(
            'Spreadsheet',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 16 / 20,
                child: EasyWebView(
                  key: webViewKey,
                  src: src,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
