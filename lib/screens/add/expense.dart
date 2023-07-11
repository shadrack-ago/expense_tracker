import 'package:expense_manager/core/models/category.dart';
import 'package:expense_manager/core/models/expense.dart';
import 'package:expense_manager/core/provider/manager.dart';
import 'package:expense_manager/router/index.dart';
import 'package:flutter/material.dart' hide MetaData;
import 'package:provider/provider.dart';

class _FormState extends ChangeNotifier {
  _FormState();
  final GlobalKey<FormState> key = GlobalKey();

  ReceiptImage? _image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController receiptController = TextEditingController();

  ReceiptImage? get receiptImage => _image;

  void setReceiptImage(ReceiptImage image, {required String name}) {
    _image = image;
    receiptController.text = name;
    notifyListeners();
  }

  void submit({required DataManager callback, required BuildContext context}) {
    if (key.currentState!.validate()) {
      var _cCurr = callback.getCategory(categoryController.text)!;
      if (_cCurr.budget < double.parse(costController.text)) {
        Navigation.alert(
          context: context,
          builder: (_context) => AlertDialog(
            title: Text('Confirm your expense'),
            content: Text(
                'Your expense exceeds your budget by ${double.parse(costController.text) - _cCurr.budget}'),
            actions: [
              TextButton.icon(
                  icon: Icon(Icons.check_rounded),
                  onPressed: () => Navigator.pop(_context),
                  label: Text('Rectify')),
              TextButton.icon(
                  icon: Icon(Icons.close_rounded),
                  onPressed: () {
                    callback.addExpense(ExpenseForm(
                      name: nameController.text,
                      categoryId: categoryController.text,
                      cost: double.parse(costController.text),
                      receiptImage: receiptImage,
                    ));
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
        callback.addExpense(ExpenseForm(
          name: nameController.text,
          categoryId: categoryController.text,
          cost: double.parse(costController.text),
          receiptImage: receiptImage,
        ));
        Navigator.of(context).pop();
      }
    }
  }
}

class AddExpense extends StatelessWidget {
  AddExpense({super.key});

  static const String id = 'add_expense';

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
          switch (_state._image?.type) {
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
        key: _state.key,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _state.nameController,
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
                  _state.categoryController.text = value!;
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: _state.costController,
                validator: ExpenseValidator.validateCost,
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon: Icon(Icons.monetization_on_rounded),
                  label: Text('Expense cost *'),
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: _state.receiptController,
                onChanged: (url) => _state
                    .setReceiptImage(ReceiptImage.fromUrl(url), name: url),
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon: DropdownButton(
                    items: [
                      DropdownMenuItem(
                          value: 1,
                          onTap: selectCamera(),
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
                onPressed: () =>
                    _state.submit(callback: callback, context: context),
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
