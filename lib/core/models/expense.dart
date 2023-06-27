import 'category.dart';

class Expense {
  int usage;
  int budget;
  ExpenseCategory category;

  Expense({required this.budget, required this.category, required this.usage});
}
