import 'dart:js_interop';

import 'package:expense_manager/core/models/category.dart';
import 'package:expense_manager/core/models/expense.dart';
import 'package:expense_manager/core/provider/manager.dart';
import 'package:expense_manager/router/index.dart';
import 'package:flutter/material.dart' hide MetaData;
import 'package:provider/provider.dart';

class _FormState extends ChangeNotifier {
  _FormState();

  ExpenseForm? initial;

  ReceiptImage? receiptImage;

  void setReceiptImage(String name) {
    switch (receiptImage?.type) {
      case null:
        receiptImage = ReceiptImage.fromUrl(name);
        break;
      case RImageType.network:
        receiptImage!.data = NetworkImage(name);
        receiptImage!.name = name;
        break;
      case RImageType.file:
        receiptImage!.name = name;
        break;
      case RImageType.memory:
        receiptImage!.name = name;
        break;
      default:
    }

    notifyListeners();
  }

  void submit(
      {required DataManager callback,
      required BuildContext context,
      required ExpenseForm form}) {
    if (initial.isNull) {
      var _cCurr = callback.getCategory(form.categoryId)!;
      if (_cCurr.budget < form.cost) {
        Navigation.alert(
          context: context,
          builder: (_context) => AlertDialog(
            title: Text('Confirm your expense'),
            content: Text(
                'Your expense exceeds your budget by ${form.cost - _cCurr.budget}'),
            actions: [
              TextButton.icon(
                  icon: Icon(Icons.check_rounded),
                  onPressed: () => Navigator.pop(_context),
                  label: Text('Rectify')),
              TextButton.icon(
                  icon: Icon(Icons.close_rounded),
                  onPressed: () {
                    callback.addExpense(form);
                    Navigator.pop(_context);
                    Navigator.of(context).pop();
                  },
                  style:
                      TextButton.styleFrom(foregroundColor: Colors.redAccent),
                  label: Text('Ignore')),
            ],
          ),
        );
      } else {
        callback.addExpense(form);
        Navigator.of(context).pop();
      }
    } else if (initial!.id.isDefinedAndNotNull) {
      callback.editExpense(form: form, id: initial!.id!);
      Navigator.of(context).pop();
    }
  }
}

class AddExpense extends StatelessWidget {
  AddExpense({super.key, Expense? expense}) {
    nameController.text = expense?.name ?? '';
    categoryController.text = expense?.categoryId ?? '';
    costController.text = expense?.cost.toString() ?? '';
    _state.receiptImage = expense?.receiptData;

    receiptController.text = expense?.receiptData?.type == RImageType.network
        ? expense?.receiptData?.data.url ?? ''
        : expense?.receiptData?.name ?? '';
  }

  static const String id = 'add_expense';
  final Expense? expense;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController receiptController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  final _FormState _state = _FormState();

  /// Creates dropdowns with values of category ID
  List<DropdownMenuItem<String>> dropdownItems(BuildContext context) {
    return Provider.of<DataManager>(context)
            .categories
            .map((category) => DropdownMenuItem(
                  child: Text(category.name),
                  value: category.meta.id,
                ))
            .toList() +
        [
          DropdownMenuItem(
            enabled: false,
            child: OutlinedButton.icon(
                onPressed: () => Navigation.addCategory(context),
                icon: Icon(Icons.add_rounded),
                label: Text('Add Category')),
          )
        ];
  }

  selectCamera() {}
  selectGallery() {}

  buildPreview() {
    return ListenableBuilder(
        listenable: _state,
        builder: (context, child) {
          switch (_state.receiptImage?.type) {
            case RImageType.network:
              return Column(
                children: [
                  Text('Receipt preview'),
                  const SizedBox(height: 10),
                  Image.network(_state.receiptImage!.data.url),
                ],
              );
            case RImageType.file:
              return Column(
                children: [
                  const SizedBox(height: 10),
                  Text('Receipt preview'),
                  Image.file(_state.receiptImage!.data.file),
                ],
              );
            case RImageType.memory:
              return Column(
                children: [
                  Text('Receipt preview'),
                  const SizedBox(height: 10),
                  Image.memory(_state.receiptImage!.data.bytes),
                ],
              );
            default:
              return Container();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    List<ExpenseCategory> retrievedCategories =
        Provider.of<DataManager>(context).categories;

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
                validator: ExpenseValidator.validateName,
                decoration: InputDecoration(
                  filled: true,
                  label: Text('Expense name *'),
                ),
              ),
              const SizedBox(height: 25),
              DropdownButtonFormField(
                items: dropdownItems(context),
                validator: (value) => ExpenseValidator.validateCategory(
                  value,
                  categories: retrievedCategories,
                ),
                decoration: InputDecoration(
                  filled: true,
                  label: Text('Expense category *'),
                ),
                onChanged: (value) {
                  categoryController.text = value!;
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: costController,
                validator: ExpenseValidator.validateCost,
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon: Icon(Icons.monetization_on_rounded),
                  label: Text('Expense cost *'),
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: receiptController,
                onChanged: (value) => _state.setReceiptImage(value),
                validator: (value) => ExpenseValidator.validateReceipt(
                    value, _state.receiptImage?.type),
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon: DropdownButton(
                    items: [
                      DropdownMenuItem(
                          value: 1,
                          onTap: () => selectCamera(),
                          child: Row(
                            children: [
                              Icon(Icons.camera_rounded),
                              Text('Camera')
                            ],
                          )),
                      DropdownMenuItem(
                          value: 2,
                          onTap: () => selectGallery(),
                          child: Row(
                            children: [
                              Icon(Icons.dashboard_customize_rounded),
                              Text('Gallery')
                            ],
                          ))
                    ],
                    hint: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.upload),
                      label: Text('Upload'),
                    ),
                    onChanged: (value) {},
                  ),
                  label: Text('Receipt url or upload image'),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _state.submit(
                      callback: callback,
                      context: context,
                      form: ExpenseForm(
                          name: nameController.text,
                          categoryId: categoryController.text,
                          cost: double.parse(costController.text),
                          receiptImage: _state.receiptImage),
                    );
                  }
                },
                icon: Icon(Icons.add_rounded),
                label: Text('Add expense'),
              ),
              const SizedBox(height: 20),
              buildPreview(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
