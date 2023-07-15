import '../models/category.dart' show CategoryForm, ExpenseCategory;
import '../models/expense.dart' show Expense, ExpenseForm, MetaData;
import '../serializers/category.dart';
import '../serializers/expense.dart';
import '../serializers/utils.dart';
import 'package:localstore/localstore.dart';

// TODO: Implement localstore persistance
class DataService {
  Localstore _db = Localstore.instance;

  final String expensesPath = 'expenses';
  final String categoriesPath = 'categories';

  Future<Map<String, dynamic>?> get expenses {
    return _db.collection(expensesPath).get();
  }

  Future<Map<String, dynamic>?> get categories {
    return _db.collection(categoriesPath).get();
  }

  Future<dynamic> addCategory(CategoryForm form) {
    return _db.collection(categoriesPath).doc(form.name.toLowerCase()).set(
          ExpenseCategory(
                  meta: MetaData.fromId(form.name.toLowerCase()),
                  name: form.name,
                  budget: form.budget)
              .serialized,
        );
  }

  Future<dynamic> addExpense(ExpenseForm form) {
    return _db.collection(expensesPath).doc(form.name.toLowerCase()).set(
          Expense(
            meta: MetaData.fromId(form.name.toLowerCase()),
            name: form.name,
            cost: form.cost,
            categoryId: form.categoryId,
            receiptData: form.receiptImage,
          ).serialized,
        );
  }

  Future<dynamic> editCategory(CategoryForm form, String id) {
    return _db.collection(categoriesPath).doc(id).set(
          ExpenseCategory(
                  meta: MetaData.fromId(form.name.toLowerCase()),
                  name: form.name,
                  budget: form.budget)
              .serialized,
        );
  }

  Future<dynamic> editExpense(ExpenseForm form, String id) {
    return _db.collection(expensesPath).doc(id).set(
          Expense(
            meta: MetaData.fromId(form.name.toLowerCase()),
            name: form.name,
            cost: form.cost,
            categoryId: form.categoryId,
            receiptData: form.receiptImage,
          ).serialized,
        );
  }

  Future<String> deleteCategory(String id) {
    return Future.error('Deleting categories is unsupported');
  }

  Future<String> deleteExpense(String id) {
    return _db
        .collection(expensesPath)
        .doc(id)
        .delete()
        .then((value) => '🎉 Successfully deleted expense')
        .onError(
            (error, stackTrace) => '⚠️ Error occured when deleting expense');
  }
}
