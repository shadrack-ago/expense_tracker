import 'package:expense_manager/core/models/category.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' hide MetaData;

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

  List<PieChartSectionData> get _sections => List.generate(4, (i) {
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Colors.amber,
              value: 40,
              title: 'Food',
            );
          case 1:
            return PieChartSectionData(
              color: Colors.blueGrey,
              value: 30,
              title: 'Rent',
            );
          case 2:
            return PieChartSectionData(
              color: Colors.lightGreenAccent.shade100,
              value: 20,
              title: 'Entertainment',
            );
          case 3:
            return PieChartSectionData(
              color: Colors.deepPurpleAccent.shade100,
              value: 10,
              title: 'Shopping',
            );
          default:
            throw Error();
        }
      });

  PieChartData get expenditureCData => PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {},
        ),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: _sections,
      );
  PieChartData get savingCData => PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {},
        ),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: _sections,
      );
}
