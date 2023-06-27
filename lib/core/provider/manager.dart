import '../models/category.dart';
import '../models/expense.dart';
import 'package:flutter/material.dart';

class DataManager extends ChangeNotifier {
  List<Expense> _expenses = [
    Expense(budget: 200, category: ExpenseCategory(name: 'Food'), usage: 100)
  ];

  List<Expense> get expense => _expenses;

  addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  removeExpense() {}
}
