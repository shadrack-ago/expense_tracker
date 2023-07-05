import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Expense {
  int cost;
  String name;
  MetaData meta;
  ReceiptImage? receiptURL;

  /// This correlates to the category id.
  String categoryId;

  Expense({
    required this.meta,
    required this.name,
    required this.categoryId,
    required this.cost,
    this.receiptURL,
  });
}

class MetaData {
  DateTime timeRecorded;
  String id;

  MetaData({required this.id, required this.timeRecorded});
}

/// Receipt image type
enum RImageType { network, memory, file }

class ReceiptImage<T> {
  RImageType type;
  T src;
  ReceiptImage({required this.type, required this.src});
}
