import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const String id = 'home';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(id),
    );
  }
}
