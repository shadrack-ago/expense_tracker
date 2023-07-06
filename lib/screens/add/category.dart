import 'package:expense_manager/core/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/manager.dart';

class AddCategory extends StatelessWidget {
  AddCategory({super.key});

  static const String id = 'add_category';

  final GlobalKey<FormState> _addCategory = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _addCategory,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                validator: CategoryValidator.validateName,
                decoration: InputDecoration(
                  filled: true,
                  label: Text('Category name *'),
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: _budgetController,
                validator: CategoryValidator.validateBudget,
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon: Icon(Icons.monetization_on_rounded),
                  label: Text('Budget *'),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                  onPressed: () {
                    if (_addCategory.currentState!.validate()) {
                      Provider.of<DataManager>(context, listen: false)
                          .addCategory(
                        name: _nameController.text,
                        budget: double.parse(_budgetController.text),
                      );
                      Navigator.pop(context);
                    }
                  },
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
