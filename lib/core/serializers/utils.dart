import 'package:expense_manager/core/models/category.dart';
import 'package:expense_manager/core/serializers/category.dart';
import 'package:expense_manager/core/serializers/expense.dart';

import '../models/expense.dart';
import 'models.dart';

extension Deserialization on Map {
  static MetaData toMeta(Map<String, dynamic> data) {
    return MetadataSerializer.deserialized(data);
  }

  ExpenseCategory get toCategory {
    return CategorySerializer.deserialized(this);
  }

  Expense get toExpense {
    return ExpenseSerializer.deserialized(this);
  }

  ReceiptImage? get toImage {
    return RImageSerializer.deserialized(this);
  }
}
