import '../models/category.dart' show ExpenseCategory;
import 'utils.dart';
import 'models.dart';

extension CategorySerializer on ExpenseCategory {
  Map<String, dynamic> get serialized {
    return {
      'name': this.name,
      'budget': this.budget,
      'meta': this.meta.serialized,
    };
  }

  static ExpenseCategory deserialized(Map categoryObj) {
    return ExpenseCategory(
      meta: Deserialization.toMeta(categoryObj['meta']),
      name: categoryObj['name'],
      budget: categoryObj['budget'],
    );
  }
}
