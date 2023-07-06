import 'package:easy_web_view/easy_web_view.dart';
import 'package:expense_manager/core/provider/manager.dart';
import 'package:expense_manager/layouts/index.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/provider/sync.dart';
import '../router/index.dart';

class Insights extends StatelessWidget {
  const Insights({super.key});

  static const String id = 'insights';

  static ValueKey webViewKey = const ValueKey('key_0');

  PieChart buildChart(PieChartData data) {
    return PieChart(
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optiona
      data,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _manager = Provider.of<DataManager>(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Breakdown',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          if (_manager.expenses.isEmpty)
            Card(
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Text(
                        "No expense entries found",
                        style: TextStyle(fontSize: 21),
                      ),
                      TextButton(
                        child: Text("Add new entries"),
                        onPressed: () => Navigation.addExpense(context),
                      )
                    ],
                  ),
                ),
              ),
            )
          else if (Breakpoints.of(context).isMobile())
            Column(
              children: [
                Card(
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expenditure habits',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Expanded(
                              child: buildChart(_manager.expenditureCData)),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saving habits',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Expanded(child: buildChart(_manager.savingCData)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            Row(children: [
              Expanded(
                child: Card(
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expenditure habits',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Expanded(
                              child: buildChart(_manager.expenditureCData)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saving habits',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Expanded(child: buildChart(_manager.savingCData)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          SizedBox(height: 12),
          Text(
            'Spreadsheet',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 16 / 20,
                child: Consumer<SyncManager>(
                  builder: (_, manager, __) => EasyWebView(
                    key: webViewKey,
                    src: manager.sheet,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
