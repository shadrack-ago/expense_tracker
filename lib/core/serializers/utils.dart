import 'package:expense_manager/core/models/category.dart';
import 'package:expense_manager/core/serializers/category.dart';
import 'package:expense_manager/core/serializers/expense.dart';

import '../models/expense.dart';
import 'models.dart';

extension Deserialization on Map<String, dynamic> {
  MetaData get toMeta {
    return MetadataSerializer.deserialized(this);
  }

  static ExpenseCategory toCategory(Map<String, dynamic> data) {
    return CategorySerializer.deserialized(data);
  }

  Expense get toExpense {
    return ExpenseSerializer.deserialized(this);
  }

  ReceiptImage? get toImage {
    return RImageSerializer.deserialized(this);
  }
}
