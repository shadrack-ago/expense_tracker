import 'package:expense_manager/core/provider/manager.dart';
import 'package:expense_manager/layouts/index.dart';
import 'package:expense_manager/router/index.dart';
import 'package:fl_heatmap/fl_heatmap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  static const String id = 'home';

  @override
  Widget build(BuildContext context) {
    final _manager = Provider.of<DataManager>(context);

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
                    SizedBox(height: 10),
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
                                    Heatmap(heatmapData: _manager.weekly),
                                    Heatmap(heatmapData: _manager.monthly),
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
                                    Heatmap(heatmapData: _manager.weekly),
                                    Heatmap(heatmapData: _manager.monthly),
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
                return data.expenses.length > 0
                    ? ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: data.expenses.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(data.expenses[index].name),
                              subtitle: Text(data
                                      .getCategory(
                                          data.expenses[index].categoryId)
                                      ?.name ??
                                  'Unable to fetch category reload'),
                              trailing:
                                  Text('Ksh ${data.expenses[index].cost}'),
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
          onPressed: () => Navigation.addExpense(context),
        )
      ],
    );
  }
}
