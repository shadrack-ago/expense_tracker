import 'package:expense_manager/core/models/category.dart';
import 'package:expense_manager/core/models/expense.dart';
import 'package:localstore/localstore.dart';

class DataService {
  Localstore _db = Localstore.instance;

  addCategory() {}
  addExpense() {}

  List<Expense> get expenses {
    return [];
  }

  List<ExpenseCategory> get categories {
    return [];
  }
}
