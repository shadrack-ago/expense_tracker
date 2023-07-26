import 'dart:async';

import 'package:expense_manager/core/serializers/utils.dart';
import 'package:expense_manager/core/services/data.dart';
import 'package:expense_manager/router/index.dart';
import 'package:flutter/foundation.dart';

import '../models/category.dart';
import '../../utils/extensions/date.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fl_heatmap/fl_heatmap.dart';
import 'package:flutter/material.dart' hide MetaData;

import '../models/expense.dart';

class DataManager extends ChangeNotifier {
  DataService _service = DataService();

  Future<List<Expense>?> get expenses => compute(
      (_) => _service.expenses.then((value) =>
          value?.entries.map((e) => Map.castFrom(e.value).toExpense).toList()),
      null);

  Future<List<ExpenseCategory>?> get categories => compute(
      (_) => _service.categories.then((value) => value?.entries
          .map<ExpenseCategory>((e) => Map.castFrom(e.value).toCategory)
          .toList()),
      null);

  Future addCategory(CategoryForm form) => compute(
      (_) => _service.addCategory(form).then((message) {
            notifyListeners();
            return message;
          }),
      null);

  Future addExpense(ExpenseForm form) => compute(
      (_) => _service.addExpense(form).then((message) {
            notifyListeners();
            return message;
          }),
      null);

  Future editCategory({required CategoryForm form, required String id}) =>
      compute(
          (_) => _service.editCategory(form, id).then((message) {
                notifyListeners();
                return message;
              }),
          null);

  Future editExpense({required ExpenseForm form, required String id}) =>
      compute(
          (_) => _service.editExpense(form, id).then((message) {
                notifyListeners();
                return message;
              }),
          null);

  Future deleteExpense({required String id}) {
    return _service.deleteExpense(id).then((message) {
      notifyListeners();
      return message;
    });
  }

  Future deleteCategory({required String id}) {
    return _service.deleteCategory(id).then((message) {
      notifyListeners();
      return message;
    });
  }

  Future<ExpenseCategory?> getCategory(String id) => categories.then((value) {
        if (value != null && value.isNotEmpty) {
          return value.firstWhere((element) => element.meta.id == id);
        }
        return null;
      });

  void listeners(BuildContext context) {
    /// Listen for overdrafts
    addListener(() async {
      final _savings = await savings;
      for (var saving in _savings.entries) {
        if (saving.value < 0) {
          Timer(const Duration(seconds: 2), () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'You have exceeded your budget for ${saving.key} by ${saving.value}'),
                action: SnackBarAction(
                    label: 'Update budget',
                    onPressed: () async => Navigation.editCategory(context,
                        category: await getCategory(saving.key.toLowerCase()))),
              ),
            );
          });
        }
      }
    });
  }

  /// Expenditure calculator
  Future<Map<String, double>> get expenditure => compute((_) async {
        Map<String, Map<String, double>> temp = {};
        Map<String, double> res = {};
        final _expenses = await expenses;

        if (temp.isEmpty && _expenses != null && _expenses.isNotEmpty) {
          final _category = await getCategory(_expenses[0].categoryId);
          if (_category != null) {
            temp.addAll({
              _category.name: {_expenses[0].meta.id: _expenses[0].cost}
            });
          }
        }

        if (_expenses != null) {
          for (var eIndex = 0; eIndex < _expenses.length; eIndex++) {
            for (var dIndex = 0; dIndex < temp.length; dIndex++) {
              /// Current category in the loop
              ExpenseCategory? _cCurr =
                  await getCategory(_expenses[eIndex].categoryId);

              /// Current expense
              Expense _cExp = _expenses[eIndex];

              /// Current key in data map
              String dKey = temp.keys.toList()[dIndex];
              Map<String, double> dValue = temp[dKey]!;

              if (_cCurr != null) {
                if (_cCurr.name == dKey && dValue.keys.first != _cExp.meta.id) {
                  temp[dKey] = {
                    _cExp.meta.id: dValue.values.first + _cExp.cost
                  };
                } else if (_cCurr.name != dKey &&
                    dValue.keys.first != _cExp.meta.id) {
                  if (temp[_cCurr.name] == null) {
                    temp.addAll({
                      _cCurr.name: {_cExp.meta.id: _cExp.cost}
                    });
                  }
                }
              }
            }
          }
        }
        for (var element in temp.entries) {
          res.addAll({element.key: element.value.values.first});
        }

        return res;
      }, null);

  /// Savings calculator
  Future<Map<String, double>> get savings async {
    Map<String, Map<String, double>> temp = {};
    Map<String, double> res = {};
    final _expenses = await expenses;

    if (temp.isEmpty && _expenses!.isNotEmpty) {
      final _category = await getCategory(_expenses[0].categoryId);
      if (_category != null) {
        double saving = _category.budget - _expenses[0].cost;
        if (saving > 0)
          temp.addAll({
            _category.name: {_expenses[0].meta.id: saving}
          });
      }
    }

    if (_expenses != null) {
      for (var eIndex = 0; eIndex < _expenses.length; eIndex++) {
        for (var dIndex = 0; dIndex < temp.length; dIndex++) {
          /// Current category in the loop
          ExpenseCategory? _cCurr =
              await getCategory(_expenses[eIndex].categoryId);

          /// Current expense
          Expense _cExp = _expenses[eIndex];

          /// Current key in data map
          String dKey = temp.keys.toList()[dIndex];

          /// Current data value
          Map<String, double> dValue = temp[dKey]!;

          if (_cCurr != null) {
            if (_cCurr.name == dKey && dValue.keys.first != _cExp.meta.id) {
              temp[dKey] = {_cExp.meta.id: dValue.values.first - _cExp.cost};
            } else if (_cCurr.name != dKey &&
                dValue.keys.first != _cExp.meta.id) {
              if (temp[_cCurr.name] == null) {
                temp.addAll({
                  _cCurr.name: {_cExp.meta.id: _cCurr.budget - _cExp.cost}
                });
              }
            }
          }
        }
      }
    }

    for (var element in temp.entries) {
      res.addAll({element.key: element.value.values.first});
    }

    return res;
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
  Future<HeatmapData> get weeklyHeatmapData async {
    const rows = ['Days'];
    const cols = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"];
    List<double> data = List.filled(cols.length, 0);
    final _expenses = await expenses;

    if (_expenses != null) {
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
    }

    return _buildHeatmapData(
      columns: cols,
      rows: rows,
      data: data,
    );
  }

  /// Monthly tracking heatmap data
  Future<HeatmapData> get monthlyHeatmapData async {
    const rows = ['Weeks'];
    const cols = ['1', '', '2', '', '3', '', '4'];

    List<double> data = List.filled(cols.length, 0);
    final _expenses = await expenses;

    if (_expenses != null) {
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
    }

    return _buildHeatmapData(
      columns: cols,
      rows: rows,
      data: data,
    );
  }

  /// Expendicture chart data
  Future<PieChartData> get expenditureCData async {
    Map<String, double> data = await expenditure;

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
  Future<PieChartData> get savingCData async {
    Map<String, double> data = await savings;

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
