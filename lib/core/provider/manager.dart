import 'package:expense_manager/router/index.dart';

import '../models/category.dart';
import '../../utils/extensions/date.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fl_heatmap/fl_heatmap.dart';
import 'package:flutter/material.dart' hide MetaData;

import '../models/expense.dart';

class DataManager extends ChangeNotifier {
  List<Expense> _expenses = [];

  List<ExpenseCategory> _categories = [];

  List<Expense> get expenses => _expenses;
  List<ExpenseCategory> get categories => _categories;

  ExpenseCategory? getCategory(String id) {
    ExpenseCategory? res;
    if (categories.isNotEmpty)
      categories.forEach((element) {
        if (element.meta.id == id) res = element;
      });
    return res;
  }

  BuildContext? _context;

  addContext(BuildContext context) {
    _context = _context;
  }

  listeners() {
    /// Listen for overdrafts
    addListener(() {
      for (var saving in savings.entries) {
        if (_context != null) {
          if (saving.value < 0) {
            ScaffoldMessenger.of(_context!).showSnackBar(
              SnackBar(
                showCloseIcon: true,
                content: Text(
                    'You have exceeded your budget for ${saving.key} by ${saving.value}'),
                elevation: 10,
                action:
                    SnackBarAction(label: 'Update budget', onPressed: () {}),
              ),
            );
          }
        }
      }
    });
  }

  /// Expenditure calculator
  Map<String, double> get expenditure {
    Map<String, Map<String, double>> temp = {};
    Map<String, double> res = {};

    if (temp.isEmpty && _expenses.isNotEmpty) {
      temp.addAll({
        getCategory(_expenses[0].categoryId)!.name: {
          _expenses[0].meta.id: _expenses[0].cost
        }
      });
    }

    for (var eIndex = 0; eIndex < _expenses.length; eIndex++) {
      for (var dIndex = 0; dIndex < temp.length; dIndex++) {
        /// Current category in the loop
        ExpenseCategory _cCurr = getCategory(_expenses[eIndex].categoryId)!;

        /// Current expense
        Expense _cExp = _expenses[eIndex];

        /// Current key in data map
        String dKey = temp.keys.toList()[dIndex];
        Map<String, double> dValue = temp[dKey]!;

        if (_cCurr.name == dKey && _cExp.meta.id != dValue.keys.first) {
          temp[dKey]![dValue.keys.first] = dValue.values.first + _cExp.cost;
        } else if (_cCurr.name != dKey && _cExp.meta.id != dValue.keys.first) {
          if (temp[_cCurr.name] == null) {
            temp.addAll({
              _cCurr.name: {_cExp.meta.id: _cExp.cost}
            });
          }
        }
      }
    }
    for (var element in temp.entries) {
      res.addAll({element.key: element.value.values.first});
    }

    return res;
  }

  /// Savings calculator
  Map<String, double> get savings {
    Map<String, Map<String, double>> temp = {};
    Map<String, double> res = {};

    if (temp.isEmpty && _expenses.isNotEmpty) {
      double saving =
          getCategory(_expenses[0].categoryId)!.budget - _expenses[0].cost;
      if (saving > 0)
        temp.addAll({
          getCategory(_expenses[0].categoryId)!.name: {
            _expenses[0].meta.id: saving
          }
        });
    }

    for (var eIndex = 0; eIndex < _expenses.length; eIndex++) {
      for (var dIndex = 0; dIndex < temp.length; dIndex++) {
        /// Current category in the loop
        ExpenseCategory _cCurr = getCategory(_expenses[eIndex].categoryId)!;

        /// Current expense
        Expense _cExp = _expenses[eIndex];

        /// Current key in data map
        String dKey = temp.keys.toList()[dIndex];

        /// Current data value
        Map<String, double> dValue = temp[dKey]!;

        if (_cCurr.name == dKey && dValue.keys.first != _cExp.meta.id) {
          temp[dKey] = {_cExp.meta.id: dValue.values.first - _cExp.cost};
        } else if (_cCurr.name != dKey && dValue.keys.first != _cExp.meta.id) {
          if (temp[_cCurr.name] == null) {
            temp.addAll({
              _cCurr.name: {_cExp.meta.id: _cCurr.budget - _cExp.cost}
            });
          }
        }
      }
    }

    for (var element in temp.entries) {
      res.addAll({element.key: element.value.values.first});
    }

    return res;
  }

  addCategory({
    required String name,
    required double budget,
  }) {
    _categories.add(ExpenseCategory(
      meta: MetaData.fromId(name.toLowerCase()),
      name: name,
      budget: budget,
    ));
    notifyListeners();
  }

  addExpense({
    required String name,
    required String categoryId,
    required double cost,
    ReceiptImage? receiptImage,
  }) {
    _expenses.add(Expense(
      meta: MetaData.fromId(name.toLowerCase()),
      name: name,
      categoryId: categoryId,
      cost: cost,
      receiptURL: receiptImage,
    ));

    notifyListeners();
  }

  HeatmapData _buildHeatmapData({
    required List<String> columns,
    required List<String> rows,
    required List<double> data,
  }) {
    return HeatmapData(rows: rows, columns: columns, radius: 10, colorPalette: [
      Color(0xfff8f2f2), // 0
      Color(0xffffdf9e), // 100
      Color(0xfff5e0bb), // 200
      Color(0xff785900), // 300
    ], items: [
      for (int col = 0; col < columns.length; col++)
        HeatmapItem(
            value: data[col], xAxisLabel: columns[col], yAxisLabel: rows[0])
    ]);
  }

  DateTime _now = DateTime.timestamp();

  /// Weekly tracking heatmap data
  HeatmapData get weeklyHeatmapData {
    const rows = ['Days'];
    const cols = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"];
    List<double> data = List.filled(cols.length, 0);

    for (var day = 0; day < data.length; day++) {
      for (var expense in _expenses) {
        if (expense.meta.timeRecorded
                .difference(_now.thisWeekLastDay)
                .inDays
                .abs() <=
            7) {
          if (expense.meta.timeRecorded.weekday - 1 == day) {
            data[day] = data[day] + 1;
          }
        }
      }
    }

    return _buildHeatmapData(
      columns: cols,
      rows: rows,
      data: data,
    );
  }

  /// Monthly tracking heatmap data
  HeatmapData get monthlyHeatmapData {
    const rows = ['Weeks'];
    const cols = ['1', '', '2', '', '3', '', '4'];

    List<double> data = List.filled(cols.length, 0);

    for (var week = 0; week < data.length; week++) {
      if (cols[week].isNotEmpty) {
        for (var expense in _expenses) {
          if (expense.meta.timeRecorded.month == _now.month) {
            if (expense.meta.timeRecorded.weekOfMonth ==
                int.parse(cols[week])) {
              data[week] = data[week] + 1;
            }
          }
        }
      }
    }

    return _buildHeatmapData(
      columns: cols,
      rows: rows,
      data: data,
    );
  }

  /// Expendicture chart data
  PieChartData get expenditureCData {
    Map<String, double> data = expenditure;

    return PieChartData(
      sections: data.entries
          .map<PieChartSectionData>((e) => PieChartSectionData(
                title: e.key,
                value: e.value,
              ))
          .toList(),
    );
  }

  /// Saving chart data
  PieChartData get savingCData {
    Map<String, double> data = savings;

    for (var section in data.entries.toList()) {
      if (section.value.isNegative) {
        data.remove(section.key);
      }
    }

    return PieChartData(
      sections: data.entries
          .map<PieChartSectionData>((e) => PieChartSectionData(
                title: e.key,
                value: e.value,
              ))
          .toList(),
    );
  }
}
