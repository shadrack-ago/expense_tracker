import 'package:flutter/material.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  static const String id = 'add_category';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  label: Text('Category name *'),
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon: Icon(Icons.monetization_on_rounded),
                  label: Text('Budget *'),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add_rounded),
                  label: Text('Add Category')),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
