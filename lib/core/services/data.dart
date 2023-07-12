import 'package:expense_manager/core/models/category.dart';
import 'package:expense_manager/core/models/expense.dart';
// import 'package:localstore/localstore.dart';

// TODO: Implement localstore persistance
class DataService {
  // Localstore _db = Localstore.instance;
  List<Expense> _expenses = [];
  List<ExpenseCategory> _categories = [];

  addCategory(CategoryForm form) {
    _categories.add(ExpenseCategory(
      meta: MetaData.fromId(form.name.toLowerCase()),
      name: form.name,
      budget: form.budget,
    ));
  }

  addExpense(ExpenseForm form) {
    _expenses.add(Expense(
      meta: MetaData.fromId(form.name.toLowerCase()),
      name: form.name,
      categoryId: form.categoryId,
      cost: form.cost,
      receiptData: form.receiptImage,
    ));
  }

  List<Expense> get expenses {
    return _expenses;
  }

  List<ExpenseCategory> get categories {
    return _categories;
  }

  void editCategory(CategoryForm form, String id) {}

  void editExpense(ExpenseForm form, String id) {}

  void deleteCategory(String id) {}

  void deleteExpense(String id) {}
}
