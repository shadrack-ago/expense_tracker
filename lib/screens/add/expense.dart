import 'package:easy_web_view/easy_web_view.dart';
import 'package:expense_manager/core/provider/sync.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatelessWidget {
  const AddExpense({super.key});

  static const String id = 'add_expense';

  static ValueKey webViewKey = const ValueKey('key_insight');

  @override
  Widget build(BuildContext context) {
    return Consumer<SyncManager>(
      builder: (_, manager, __) => EasyWebView(
        key: webViewKey,
        src: manager.docs,
      ),
    );
  }
}
