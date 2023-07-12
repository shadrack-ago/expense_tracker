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
  String? id;

  CategoryForm({required this.name, required this.budget, this.id});
  static CategoryForm? fromCategory(ExpenseCategory? data) {
    if (data != null) {
      return CategoryForm(
          name: data.name, budget: data.budget, id: data.meta.id);
    }
    return null;
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
    else if (double.tryParse(budget) == null)
      return 'Category budget should be a number';
    return null;
  }
}
