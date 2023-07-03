import 'package:expense_manager/router/index.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatelessWidget {
  AddExpense({super.key});

  static const String id = 'add_expense';

  List<DropdownMenuItem<String>> dropdownItems(BuildContext context) {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Food"), value: "USA"),
      DropdownMenuItem(child: Text("Entertainment"), value: "Canada"),
      DropdownMenuItem(child: Text("Travel"), value: "Brazil"),
      DropdownMenuItem(child: Text("Shopping"), value: "England"),
      DropdownMenuItem(
        enabled: false,
        child: OutlinedButton.icon(
            onPressed: () => Navigation.addCategory(context),
            icon: Icon(Icons.add_rounded),
            label: Text('Add Category')),
      )
    ];
    return menuItems;
  }

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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Url is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  label: Text('Expense name *'),
                ),
              ),
              const SizedBox(height: 25),
              DropdownButtonFormField(
                items: dropdownItems(context),
                decoration: InputDecoration(
                  filled: true,
                  label: Text('Expense category *'),
                ),
                onChanged: (value) {},
              ),
              const SizedBox(height: 25),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Url is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  label: Text('Expense cost *'),
                ),
              ),
              const SizedBox(height: 25),
              Container(color: Colors.amberAccent, height: 300, width: 700),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.image_rounded),
                  label: Text('Select receipt image')),
              Container(color: Colors.amber),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
