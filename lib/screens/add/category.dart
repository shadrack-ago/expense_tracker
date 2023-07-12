import 'dart:js_interop';

import 'package:expense_manager/core/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/manager.dart';
import '../../router/index.dart';

class _FormState {
  _FormState();

  CategoryForm? initial;

  void submit({
    required DataManager callback,
    required BuildContext context,
    required CategoryForm form,
  }) {
    if (initial.isNull) {
      if (callback.getCategory(form.name.toLowerCase()) != null) {
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
        Provider.of<DataManager>(context, listen: false).addCategory(form);
        Navigator.pop(context);
      }
    } else if (initial!.id.isDefinedAndNotNull) {
      Provider.of<DataManager>(context, listen: false).editCategory(
        form: form,
        id: initial!.id!,
      );
      Navigator.pop(context);
    }
  }
}

class AddCategory extends StatelessWidget {
  AddCategory({super.key, this.category});

  static const String id = 'add_category';

  final ExpenseCategory? category;

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

  final _FormState _state = _FormState();

  @override
  Widget build(BuildContext context) {
    DataManager callback = Provider.of<DataManager>(context, listen: false);

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                validator: CategoryValidator.validateName,
                decoration: InputDecoration(
                  filled: true,
                  label: Text('Category name *'),
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: budgetController,
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
                    if (formKey.currentState!.validate()) {
                      _state.submit(
                        callback: callback,
                        context: context,
                        form: CategoryForm(
                            name: nameController.text,
                            budget: double.parse(budgetController.text)),
                      );
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
