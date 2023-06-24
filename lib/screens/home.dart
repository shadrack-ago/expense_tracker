import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  static const String id = 'home';

  final List<String> items = List<String>.generate(100, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expenses',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Expanded(
          flex: 2,
          child: items.length > 0
              ? ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemCount: items.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(items[index]),
                      ),
                    );
                  },
                )
              : Center(child: noExpenseDefault(context)),
        ),
      ],
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
