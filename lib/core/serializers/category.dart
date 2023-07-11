import 'package:expense_manager/core/models/category.dart';

extension CategorySerializer on ExpenseCategory {
  Map<String, dynamic> get serialized {
    return {
      'name': this.name,
      'budget': this.budget,
      'meta': this.meta.serialized,
    };
  }

  static ExpenseCategory deserialized(Map<String, dynamic> categoryObj) {
    return ExpenseCategory(
      meta: categoryObj['meta'].toMeta,
      name: categoryObj['name'],
      budget: categoryObj['budget'],
    );
  }
}
