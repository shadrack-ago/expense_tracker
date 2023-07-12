import 'package:expense_manager/core/models/category.dart';
import 'package:expense_manager/core/models/expense.dart';
// import 'package:localstore/localstore.dart';

// TODO: Implement localstore persistance
class DataService {
  // Localstore _db = Localstore.instance;
  List<Expense> _expenses = [];
  List<ExpenseCategory> _categories = [];

  List<Expense> get expenses {
    return _expenses;
  }

  List<ExpenseCategory> get categories {
    return _categories;
  }

  Future<dynamic> addCategory(CategoryForm form) {
    _categories.add(ExpenseCategory(
      meta: MetaData.fromId(form.name.toLowerCase()),
      name: form.name,
      budget: form.budget,
    ));
    return Future.value();
  }

  Future<dynamic> addExpense(ExpenseForm form) {
    _expenses.add(Expense(
      meta: MetaData.fromId(form.name.toLowerCase()),
      name: form.name,
      categoryId: form.categoryId,
      cost: form.cost,
      receiptData: form.receiptImage,
    ));
    return Future.value();
  }

  Future<dynamic> editCategory(CategoryForm form, String id) {
    return Future.value();
  }

  Future<dynamic> editExpense(ExpenseForm form, String id) {
    return Future.value();
  }

  Future<String> deleteCategory(String id) {
    return Future.error('Deleting categories is unsupported');
  }

  Future<String> deleteExpense(String id) {
    return Future.value('🎉 Successfully deleted expense');
  }
}
