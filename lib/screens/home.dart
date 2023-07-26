import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const String id = 'home';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
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
                                    FutureBuilder(
                                      future: _manager.weeklyHeatmapData,
                                      builder: (context, snapshot) {
                                        final data = snapshot.data;
                                        if (data != null) {
                                          return Heatmap(heatmapData: data);
                                        } else
                                          return Heatmap(
                                            heatmapData: HeatmapData(
                                                rows: ['Days'],
                                                columns: [
                                                  "Mon",
                                                  "Tue",
                                                  "Wed",
                                                  "Thur",
                                                  "Fri",
                                                  "Sat",
                                                  "Sun"
                                                ],
                                                radius: 10,
                                                colorPalette: [
                                                  Color(0xfff8f2f2), // 0
                                                  Color(0xffffdf9e), // 100
                                                  Color(0xfff5e0bb), // 200
                                                  Color(0xff785900), // 300
                                                ],
                                                items: [
                                                  for (int col = 0;
                                                      col <
                                                          [
                                                            "Mon",
                                                            "Tue",
                                                            "Wed",
                                                            "Thur",
                                                            "Fri",
                                                            "Sat",
                                                            "Sun"
                                                          ].length;
                                                      col++)
                                                    HeatmapItem(
                                                        value: 0,
                                                        xAxisLabel: [
                                                          "Mon",
                                                          "Tue",
                                                          "Wed",
                                                          "Thur",
                                                          "Fri",
                                                          "Sat",
                                                          "Sun"
                                                        ][col],
                                                        yAxisLabel: ['Days'][0])
                                                ]),
                                          );
                                      },
                                    ),
                                    FutureBuilder(
                                      future: _manager.monthlyHeatmapData,
                                      builder: (context, snapshot) {
                                        final data = snapshot.data;
                                        if (data != null) {
                                          return Heatmap(heatmapData: data);
                                        } else
                                          return Heatmap(
                                              heatmapData: HeatmapData(
                                                  rows: ['Weeks'],
                                                  columns: [
                                                    '1',
                                                    '',
                                                    '2',
                                                    '',
                                                    '3',
                                                    '',
                                                    '4'
                                                  ],
                                                  radius: 10,
                                                  colorPalette: [
                                                    Color(0xfff8f2f2), // 0
                                                    Color(0xffffdf9e), // 100
                                                    Color(0xfff5e0bb), // 200
                                                    Color(0xff785900), // 300
                                                  ],
                                                  items: [
                                                    for (int col = 0;
                                                        col <
                                                            [
                                                              '1',
                                                              '',
                                                              '2',
                                                              '',
                                                              '3',
                                                              '',
                                                              '4'
                                                            ].length;
                                                        col++)
                                                      HeatmapItem(
                                                          value: 0,
                                                          xAxisLabel: [
                                                            '1',
                                                            '',
                                                            '2',
                                                            '',
                                                            '3',
                                                            '',
                                                            '4'
                                                          ][col],
                                                          yAxisLabel: [
                                                            'Weeks'
                                                          ][0])
                                                  ]));
                                      },
                                    ),
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
                                    FutureBuilder(
                                      future: _manager.weeklyHeatmapData,
                                      builder: (context, snapshot) {
                                        final data = snapshot.data;
                                        if (data != null) {
                                          return Heatmap(heatmapData: data);
                                        } else
                                          return Heatmap(
                                            heatmapData: HeatmapData(
                                                rows: ['Days'],
                                                columns: [
                                                  "Mon",
                                                  "Tue",
                                                  "Wed",
                                                  "Thur",
                                                  "Fri",
                                                  "Sat",
                                                  "Sun"
                                                ],
                                                radius: 10,
                                                colorPalette: [
                                                  Color(0xfff8f2f2), // 0
                                                  Color(0xffffdf9e), // 100
                                                  Color(0xfff5e0bb), // 200
                                                  Color(0xff785900), // 300
                                                ],
                                                items: [
                                                  for (int col = 0;
                                                      col <
                                                          [
                                                            "Mon",
                                                            "Tue",
                                                            "Wed",
                                                            "Thur",
                                                            "Fri",
                                                            "Sat",
                                                            "Sun"
                                                          ].length;
                                                      col++)
                                                    HeatmapItem(
                                                        value: 0,
                                                        xAxisLabel: [
                                                          "Mon",
                                                          "Tue",
                                                          "Wed",
                                                          "Thur",
                                                          "Fri",
                                                          "Sat",
                                                          "Sun"
                                                        ][col],
                                                        yAxisLabel: ['Days'][0])
                                                ]),
                                          );
                                      },
                                    ),
                                    FutureBuilder(
                                      future: _manager.monthlyHeatmapData,
                                      builder: (context, snapshot) {
                                        final data = snapshot.data;
                                        if (data != null) {
                                          return Heatmap(heatmapData: data);
                                        } else
                                          return Heatmap(
                                              heatmapData: HeatmapData(
                                                  rows: ['Weeks'],
                                                  columns: [
                                                    '1',
                                                    '',
                                                    '2',
                                                    '',
                                                    '3',
                                                    '',
                                                    '4'
                                                  ],
                                                  radius: 10,
                                                  colorPalette: [
                                                    Color(0xfff8f2f2), // 0
                                                    Color(0xffffdf9e), // 100
                                                    Color(0xfff5e0bb), // 200
                                                    Color(0xff785900), // 300
                                                  ],
                                                  items: [
                                                    for (int col = 0;
                                                        col <
                                                            [
                                                              '1',
                                                              '',
                                                              '2',
                                                              '',
                                                              '3',
                                                              '',
                                                              '4'
                                                            ].length;
                                                        col++)
                                                      HeatmapItem(
                                                          value: 0,
                                                          xAxisLabel: [
                                                            '1',
                                                            '',
                                                            '2',
                                                            '',
                                                            '3',
                                                            '',
                                                            '4'
                                                          ][col],
                                                          yAxisLabel: [
                                                            'Weeks'
                                                          ][0])
                                                  ]));
                                      },
                                    ),
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
            child: FutureBuilder(
              future: _manager.expenses,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                return data.length > 0
                    ? ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: data.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(data[index].name),
                              subtitle: FutureBuilder(
                                future: _manager
                                    .getCategory(data[index].categoryId),
                                builder: (context, snapshot) => Text(
                                    snapshot.data?.name ??
                                        'Unable to fetch category reload'),
                              ),
                              trailing: Text('Ksh ${data[index].cost}'),
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
}

class ExpenseHero extends StatelessWidget {
  const ExpenseHero({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
