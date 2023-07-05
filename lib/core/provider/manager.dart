import 'dart:math';

import 'package:expense_manager/core/models/category.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fl_heatmap/fl_heatmap.dart';
import 'package:flutter/material.dart' hide MetaData;

import '../models/expense.dart';

class DataManager extends ChangeNotifier {
  List<Expense> _expenses = [];

  List<ExpenseCategory> _categories = [];

  List<Expense> get expense => _expenses;
  List<ExpenseCategory> get categories => _categories;

  ExpenseCategory? getCategory(String id) {
    if (categories.isNotEmpty)
      return categories.firstWhere((element) => element.meta.id == id);
    return null;
  }

  addCategory({
    required String name,
    required int budget,
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
    required int cost,
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

  /// Responsible for creating chart section colors
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

  /// Expendicture chart data
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

  /// Saving chart data
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
