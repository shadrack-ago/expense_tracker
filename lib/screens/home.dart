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
        children: [ExpenseHero(), ExpenseList()],
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
