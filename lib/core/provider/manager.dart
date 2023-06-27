import 'package:expense_manager/core/models/category.dart';
import 'package:flutter/widgets.dart' hide MetaData;

import '../models/expense.dart';

class DataManager extends ChangeNotifier {
  List<Expense> _expenses = [
    Expense(
      meta: MetaData(id: 'dsjfjksdf', timeRecorded: DateTime.timestamp()),
      name: 'Tomato Shopping',
      categoryId: 'Food',
      cost: 100,
    )
  ];

  List<ExpenseCategory> _categories = [
    ExpenseCategory(
      meta: MetaData(id: 'dsjfjksdf', timeRecorded: DateTime.timestamp()),
      name: 'Food',
      budget: 400,
    )
  ];

  List<Expense> get expense => _expenses;
  List<ExpenseCategory> get categories => _categories;

  addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  removeExpense() {}
}
