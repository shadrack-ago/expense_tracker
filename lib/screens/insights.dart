import 'package:easy_web_view/easy_web_view.dart';
import 'package:expense_manager/layouts/index.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Insights extends StatelessWidget {
  const Insights({super.key});

  static const String id = 'insights';

  static ValueKey webViewKey = const ValueKey('key_0');

  final String src =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vSGbFtRPwKfGW2rxaWOo8d6zONVIaSTYDbrTRboCNIffzq6bm4bFNof5Rax5Z3QQWepAwZ4tbslEQLY/pubhtml';

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

  PieChartData get _sample => PieChartData(
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

  PieChart buildChart(PieChartData data) {
    return PieChart(
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optiona
      data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Breakdown',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          if (Breakpoints.of(context).isMobile())
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
                                .titleSmall!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Expanded(child: buildChart(_sample)),
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
                                .titleSmall!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Expanded(child: buildChart(_sample)),
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
                          Expanded(child: buildChart(_sample)),
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
                          Expanded(child: buildChart(_sample)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          SizedBox(height: 10),
          Text(
            'Spreadsheet',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 16 / 20,
                child: EasyWebView(
                  key: webViewKey,
                  src: src,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
