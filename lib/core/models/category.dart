import 'expense.dart';

class ExpenseCategory {
  String name;
  MetaData meta;
  int budget;

  ExpenseCategory({
    required this.meta,
    required this.name,
    required this.budget,
  });
}


class CategoryValidator {
  static String? validateName(String? name) {
    if (name == null) return 'An Expense should have a name';
    return null;
  }

  static String? validateBudget(String? budget) {
    if (budget == null)
      return 'Category should have a budget';
    else if (budget is int == false)
      return 'Category budget should be a number';
    return null;
  }
}
