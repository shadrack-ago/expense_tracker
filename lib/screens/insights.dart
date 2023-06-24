import 'package:expense_manager/layouts/index.dart';
import 'package:flutter/material.dart';

class Insights extends StatelessWidget {
  const Insights({super.key});

  static const String id = 'insights';

  List<Widget> get graphs {
    return [
      Expanded(
          child: Card(child: Column(children: [Text('Expenditure habits')]))),
      Expanded(child: Card(child: Column(children: [Text('Saving habits')])))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            flex: 1,
          child: Breakpoints.of(context).isMobile()
              ? Column(
                  children: graphs,
                )
              : Row(children: graphs),
        ),
        SizedBox(height: 10),
        Expanded(
          flex: 2,
          child: Placeholder(),
        ),
      ],
    );
  }
}
