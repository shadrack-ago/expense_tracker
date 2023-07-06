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
    Map<String, double> data = {'Food': 200};

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
    Map<String, double> data = {'Food': 200};

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
