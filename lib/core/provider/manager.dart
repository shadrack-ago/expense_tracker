import 'package:expense_manager/core/models/category.dart';
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
    if (categories.isNotEmpty)
      return categories.firstWhere((element) => element.meta.id == id);
    return null;
  }

  addCategory({
    required String name,
    required double budget,
  }) {
    _categories.add(ExpenseCategory(
      meta: MetaData.fromId('sdjfhsd878123mnsdfj'),
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
      meta: MetaData.fromId('sdjfhsdhfj788k'),
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

  /// Weekly tracking heatmap data
  HeatmapData get weekly {
    const rows = ['Days'];
    const cols = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"];
    return _buildHeatmapData(
      columns: cols,
      rows: rows,
      data: List.filled(cols.length, 0),
    );
  }

  /// Monthly tracking heatmap data
  HeatmapData get monthly {
    const rows = ['Weeks'];
    const cols = ['1', '', '2', '', '3', '', '4'];
    return _buildHeatmapData(
      columns: cols,
      rows: rows,
      data: List.filled(cols.length, 0),
    );
  }

  /// Expendicture chart data
  PieChartData get expenditureCData {
    Map<String, Map<String, double>> data = {};

    if (data.isEmpty && _expenses.isNotEmpty) {
      data.addAll({
        getCategory(_expenses[0].categoryId)!.name: {
          _expenses[0].meta.id: _expenses[0].cost
        }
      });
    }

    for (var eIndex = 0; eIndex < _expenses.length; eIndex++) {
      for (var dIndex = 0; dIndex < data.length; dIndex++) {
        /// Current category in the loop
        ExpenseCategory _cCurr = getCategory(_expenses[eIndex].categoryId)!;

        /// Current expense
        Expense _cExp = _expenses[eIndex];

        /// Current key in data map
        String dKey = data.keys.toList()[dIndex];
        Map<String, double> dValue = data[dKey]!;

        if (_cCurr.name == dKey && _cExp.meta.id != dValue.keys.first) {
          data[dKey]![dValue.keys.first] = dValue.values.first + _cExp.cost;
        } else if (_cCurr.name != dKey && _cExp.meta.id != dValue.keys.first) {
          data.addAll({
            _cCurr.name: {_cExp.meta.id: _cExp.cost}
          });
        }
      }
    }

    return PieChartData(
      sections: data.entries
          .map<PieChartSectionData>((e) => PieChartSectionData(
                title: e.key,
                value: e.value.entries.first.value,
              ))
          .toList(),
    );
  }

  /// Saving chart data
  PieChartData get savingCData {
    Map<String, Map<String, double>> data = {};

    if (data.isEmpty && _expenses.isNotEmpty) {
      double saving =
          getCategory(_expenses[0].categoryId)!.budget - _expenses[0].cost;
      if (saving > 0)
        data.addAll({
          getCategory(_expenses[0].categoryId)!.name: {
            _expenses[0].meta.id: saving
          }
        });
    }

    for (var eIndex = 0; eIndex < _expenses.length; eIndex++) {
      for (var dIndex = 0; dIndex < data.length; dIndex++) {
        /// Current category in the loop
        ExpenseCategory _cCurr = getCategory(_expenses[eIndex].categoryId)!;

        /// Current expense
        Expense _cExp = _expenses[eIndex];

        /// Current key in data map
        String dKey = data.keys.toList()[dIndex];
        Map<String, double> dValue = data[dKey]!;

        double saving = _cCurr.budget - _cExp.cost;

        if (saving > 0) {
          if (_cCurr.name == dKey && _cExp.meta.id != dValue.keys.first) {
            data[dKey]![dValue.keys.first] = saving - _cExp.cost;
          } else if (_cCurr.name != dKey &&
              _cExp.meta.id != dValue.keys.first) {
            data.addAll({
              _cCurr.name: {_cExp.meta.id: saving}
            });
          }
        }
      }
    }

    return PieChartData(
      sections: data.entries
          .map<PieChartSectionData>((e) => PieChartSectionData(
                title: e.key,
                value: e.value.entries.first.value,
              ))
          .toList(),
    );
  }
}
