import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatelessWidget {
  const AddExpense({super.key});

  static const String id = 'add_expense';

  static ValueKey webViewKey = const ValueKey('key_insight');

  final String src =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vSGbFtRPwKfGW2rxaWOo8d6zONVIaSTYDbrTRboCNIffzq6bm4bFNof5Rax5Z3QQWepAwZ4tbslEQLY/pubhtml';

  @override
  Widget build(BuildContext context) {
    return EasyWebView(
      key: webViewKey,
      src: src,
    );
  }
}
