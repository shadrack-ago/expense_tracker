import 'package:expense_manager/core/models/category.dart';
import 'package:expense_manager/core/models/expense.dart';
import 'package:expense_manager/core/provider/manager.dart';
import 'package:expense_manager/router/index.dart';
import 'package:flutter/material.dart' hide MetaData;
import 'package:provider/provider.dart';

class _FormState extends ChangeNotifier {
  _FormState();

  ReceiptImage? _image;
  final TextEditingController _receiptController = TextEditingController();

  ReceiptImage? get receiptImage => _image;
  TextEditingController get receiptController => _receiptController;

  void setReceiptImage(ReceiptImage image, {required String name}) {
    _image = image;
    _receiptController.text = name;
    notifyListeners();
  }
}

class AddExpense extends StatelessWidget {
  AddExpense({super.key});

  static const String id = 'add_expense';

  final GlobalKey<FormState> _addExpense = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _costController = TextEditingController();

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
    return AnimatedBuilder(
      animation: _state,
      builder: (context, child) {
        return ListenableBuilder(
            listenable: _state,
            builder: (context, child) {
              switch (_state._image?.type) {
                case RImageType.network:
                  return Column(
                    children: [
                      Text('Receipt preview'),
                      const SizedBox(height: 10),
                      Image.network(_state.receiptImage!.src.url),
                    ],
                  );
                case RImageType.file:
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      Text('Receipt preview'),
                      Image.file(_state.receiptImage!.src.file),
                    ],
                  );
                case RImageType.memory:
                  return Column(
                    children: [
                      Text('Receipt preview'),
                      const SizedBox(height: 10),
                      Image.memory(_state.receiptImage!.src.bytes),
                    ],
                  );
                default:
                  return Container();
              }
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ExpenseCategory> retrievedCategories =
        Provider.of<DataManager>(context).categories;
    return SingleChildScrollView(
      child: Form(
        key: _addExpense,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
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
                  _categoryController.text = value!;
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: _costController,
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
                onPressed: () {
                  if (_addExpense.currentState!.validate()) {
                    Provider.of<DataManager>(context, listen: false).addExpense(
                      name: _nameController.text,
                      categoryId: _categoryController.text,
                      cost: double.parse(_costController.text),
                      receiptImage: _state.receiptImage,
                    );
                    Navigator.pop(context);
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
