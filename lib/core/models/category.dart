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
