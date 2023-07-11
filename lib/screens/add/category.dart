import 'package:expense_manager/core/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/manager.dart';
import '../../router/index.dart';

class _FormState {
  _FormState();
  final GlobalKey<FormState> key = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

  void submit({required DataManager callback, required BuildContext context}) {
    if (key.currentState!.validate()) {
      if (callback.getCategory(nameController.text.toLowerCase()) != null) {
        Navigation.alert(
          context: context,
          builder: (_context) => AlertDialog(
            title: Text('Category already exists'),
            content: Text(
                'The Category already exists please create a new one or edit the category'),
            actions: [
              TextButton.icon(
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => Navigator.pop(_context),
                  style:
                      TextButton.styleFrom(foregroundColor: Colors.blueAccent),
                  label: Text('Create')),
              TextButton.icon(
                  icon: Icon(Icons.edit_document),
                  onPressed: () {},
                  label: Text('Edit')),
            ],
          ),
        );
      } else {
        Provider.of<DataManager>(context, listen: false).addCategory(
          CategoryForm(
            name: nameController.text,
            budget: double.parse(budgetController.text),
          ),
        );
        Navigator.pop(context);
      }
    }
  }
}

class AddCategory extends StatelessWidget {
  AddCategory({super.key});

  static const String id = 'add_category';

  final GlobalKey<FormState> _addCategory = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DataManager dataCallback = Provider.of<DataManager>(context, listen: false);

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
                  onPressed: () =>
                      _state.submit(callback: callback, context: context),
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
