class Expense {
  int cost;
  String name;
  MetaData meta;

  /// This correlates to the category id.
  String categoryId;

  Expense({
    required this.meta,
    required this.name,
    required this.categoryId,
    required this.cost,
  });
}

class MetaData {
  DateTime timeRecorded;
  String id;

  MetaData({required this.id, required this.timeRecorded});
}
