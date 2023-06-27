import 'expense.dart';

class ExpenseCategory {
  String name;
  MetaData meta;
  int budget;
  String? description;

  ExpenseCategory({
    required this.meta,
    required this.name,
    required this.budget,
    this.description,
  });
}
