import 'models.dart';
import 'utils.dart';
import '../models/expense.dart' show Expense;

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

  static Expense deserialized(Map expenseObj) {
    return Expense(
      meta: Deserialization.toMeta(expenseObj['meta']),
      name: expenseObj['name'],
      categoryId: expenseObj['categoryId'],
      cost: expenseObj['cost'],
      receiptData: expenseObj['receiptData'].toReceipt,
    );
  }
}
