import 'package:flutter/material.dart';

class Insights extends StatelessWidget {
  const Insights({super.key});

  static const String id = 'insights';

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
          FutureBuilder(
            future: _manager.expenses,
            builder: (context, snapshot) {
              final expenses = snapshot.data ?? [];
              if (expenses.isEmpty)
                return Card(
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
                );
              else if (Breakpoints.of(context).isMobile())
                return Column(
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
                                  child: FutureBuilder(
                                      future: _manager.expenditureCData,
                                      builder: (context, snapshot) {
                                        final data = snapshot.data;
                                        if (snapshot.hasData && data != null) {
                                          return buildChart(data);
                                        } else
                                          return SizedBox();
                                      })),
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
                              Expanded(
                                  child: FutureBuilder(
                                      future: _manager.savingCData,
                                      builder: (context, snapshot) {
                                        final data = snapshot.data;
                                        if (snapshot.hasData && data != null) {
                                          return buildChart(data);
                                        } else
                                          return SizedBox();
                                      })),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              else
                return Row(children: [
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
                                  child: FutureBuilder(
                                      future: _manager.expenditureCData,
                                      builder: (context, snapshot) {
                                        final data = snapshot.data;
                                        if (snapshot.hasData && data != null) {
                                          return buildChart(data);
                                        } else
                                          return SizedBox();
                                      })),
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
                              Expanded(
                                  child: FutureBuilder(
                                      future: _manager.savingCData,
                                      builder: (context, snapshot) {
                                        final data = snapshot.data;
                                        if (snapshot.hasData && data != null) {
                                          return buildChart(data);
                                        } else
                                          return SizedBox();
                                      })),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]);
            },
          ),
          SizedBox(height: 12),
          Text(
            'More Insights',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 16 / 20,
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(tabs: [
                        Tooltip(
                          preferBelow: false,
                          message: 'Savings',
                          child: Tab(
                            text: 'Savings',
                          ),
                        ),
                        Tooltip(
                          preferBelow: false,
                          message: 'Expenditure',
                          child: Tab(
                            text: 'Expenditure',
                          ),
                        ),
                      ]),
                      SizedBox(height: 12),
                      AspectRatio(
                        aspectRatio: 16 / 4,
                        child: Consumer<DataManager>(
                          builder: (context, instance, child) {
                            return TabBarView(children: [
                              FutureBuilder(
                                future: instance.savings,
                                builder: (context, snapshot) {
                                  return snapshot.hasData
                                      ? ListView.separated(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: snapshot.data!.length,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                            height: 10,
                                          ),
                                          itemBuilder: (context, index) {
                                            return Card(
                                              child: ListTile(
                                                title: Text(snapshot.data!.keys
                                                    .toList()[index]),
                                                trailing: Text(
                                                    'Ksh ${snapshot.data!.values.toList()[index]}'),
                                              ),
                                            );
                                          },
                                        )
                                      : noExpenseDefault(context);
                                },
                              ),
                              FutureBuilder(
                                  future: instance.expenditure,
                                  builder: (context, snapshot) {
                                    return snapshot.hasData
                                        ? ListView.separated(
                                            physics: BouncingScrollPhysics(),
                                            itemCount: snapshot.data!.length,
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                              height: 10,
                                            ),
                                            itemBuilder: (context, index) {
                                              return Card(
                                                child: ListTile(
                                                  title: Text(snapshot
                                                      .data!.keys
                                                      .toList()[index]),
                                                  trailing: Text(
                                                      'Ksh ${snapshot.data!.values.toList()[index]}'),
                                                ),
                                              );
                                            },
                                          )
                                        : noExpenseDefault(context);
                                  })
                            ]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
