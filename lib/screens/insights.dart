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
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            flex: 1,
            child: Container(
              color: Colors.amber,
            )),
        SizedBox(height: 10),
        Expanded(
          flex: 2,
          child: Placeholder(),
        ),
      ],
    );
  }
}
