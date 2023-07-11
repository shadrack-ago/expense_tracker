import 'package:expense_manager/core/models/expense.dart';

extension ExpenseSerializer on Expense {
  Map<String, dynamic> get serialized {
    return {
      'name': this.name,
      'categoryID': this.categoryId,
      'cost': this.cost,
      'receiptData': this.receiptData?.serialized,
      'meta': this.meta.serialized,
    };
  }

  static Expense deserialized(Map<String, dynamic> expenseObj) {
    return Expense(
      meta: expenseObj['meta'].toMeta,
      name: expenseObj['name'],
      categoryId: expenseObj['categoryId'],
      cost: expenseObj['cost'],
      receiptData: expenseObj['receiptData'].toReceipt,
    );
  }
}
