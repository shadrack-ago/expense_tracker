import 'expense.dart';

class ExpenseCategory {
  String name;
  MetaData meta;
  double budget;

  ExpenseCategory({
    required this.meta,
    required this.name,
    required this.budget,
  });
}

/// Holds category form data
class CategoryForm {
  String name;
  double budget;

  CategoryForm({
    required this.name,
    required this.budget,
  });
  factory CategoryForm.fromExpense(ExpenseCategory data) {
    return CategoryForm(name: data.name, budget: data.budget);
  }
}

class CategoryValidator {
  static String? validateName(String? name) {
    if (name == null || name.isEmpty) return 'Category should have a name';
    return null;
  }

  static String? validateBudget(String? budget) {
    if (budget == null || budget.isEmpty)
      return 'Category should have a budget';
    else if (int.tryParse(budget) == null)
      return 'Category budget should be a number';
    return null;
  }
}
