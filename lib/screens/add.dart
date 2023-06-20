import 'package:flutter/material.dart';

class AddExpense extends StatelessWidget {
  const AddExpense({super.key});

  static const String id = 'add_expense';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(id),
    );
  }
}
