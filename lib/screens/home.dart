import 'dart:math';

import 'package:expense_manager/core/provider/manager.dart';
import 'package:expense_manager/layouts/index.dart';
import 'package:fl_heatmap/fl_heatmap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  static const String id = 'home';

  HeatmapData get _initExampleData {
    const rows = [
      '2020',
      '2019',
    ];
    const columns = [
      'Jan',
      'Feb',
      'Mär',
      'Apr',
      'Mai',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Okt',
      'Nov',
      'Dez',
    ];
    final r = Random();
    const String unit = 'kWh';
    return HeatmapData(
      rows: rows,
      columns: columns,
      radius: 10,
      colorPalette: [
        Color(0xfffffbff), // 0
        Color(0xfff8f2f2), // 100
        Color(0xffffdf9e), // 200
        Color(0xfff5e0bb), // 300
      ],
      items: [
        for (int row = 0; row < rows.length; row++)
          for (int col = 0; col < columns.length; col++)
            HeatmapItem(
              value: r.nextDouble() * 6,
              unit: unit,
              xAxisLabel: columns[col],
              yAxisLabel: rows[row],
            ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Breakpoints.of(context).isMobile()
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Expenses Tracker',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    DefaultTabController(
                      length: 2,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              TabBar(tabs: [
                                Tooltip(
                                  preferBelow: false,
                                  message: 'Weekly tracking progress',
                                  child: Tab(
                                    text: 'Weekly Progress',
                                  ),
                                ),
                                Tooltip(
                                  preferBelow: false,
                                  message: 'Monthly tracking progress',
                                  child: Tab(
                                    text: 'Monthly Progress',
                                  ),
                                ),
                              ]),
                              SizedBox(height: 12),
                              AspectRatio(
                                aspectRatio: 16 / 5,
                                child: TabBarView(
                                  children: [
                                    Heatmap(heatmapData: _initExampleData),
                                    Heatmap(heatmapData: _initExampleData),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          'Daily Expenses Tracker',
                          style: Theme.of(context).textTheme.headlineMedium,
                        )),
                    Expanded(
                        child: DefaultTabController(
                      length: 2,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              TabBar(tabs: [
                                Tooltip(
                                  preferBelow: false,
                                  message: 'Weekly tracking progress',
                                  child: Tab(
                                    text: 'Weekly Progress',
                                  ),
                                ),
                                Tooltip(
                                  preferBelow: false,
                                  message: 'Monthly tracking progress',
                                  child: Tab(
                                    text: 'Monthly Progress',
                                  ),
                                ),
                              ]),
                              SizedBox(height: 12),
                              AspectRatio(
                                aspectRatio: 16 / 4,
                                child: TabBarView(
                                  children: [
                                    Heatmap(heatmapData: _initExampleData),
                                    Heatmap(heatmapData: _initExampleData),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
          SizedBox(height: 20),
          Text(
            'Expenses',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 800,
            child: Consumer<DataManager>(
              builder: (context, data, child) {
                return data.expense.length > 0
                    ? ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: data.expense.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(data.expense[index].name),
                              subtitle: Text(data.expense[index].categoryId),
                              trailing: Text('Ksh ${data.expense[index].cost}'),
                            ),
                          );
                        },
                      )
                    : Center(child: noExpenseDefault(context));
              },
            ),
          ),
        ],
      ),
    );
  }

  Column noExpenseDefault(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "No expense entries found",
          style: TextStyle(fontSize: 21),
        ),
        TextButton(
          child: Text("Add new entries"),
          onPressed: () {},
        )
      ],
    );
  }
}
