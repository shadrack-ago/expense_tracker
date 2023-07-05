import 'dart:io';
import 'dart:typed_data';

import 'package:expense_manager/core/models/category.dart';
import 'package:expense_manager/core/provider/manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class ExpenseValidator {
  static String? validateName(String? name) {
    if (name == null || name.isEmpty) return 'An Expense should have a name';
    return null;
  }

  static String? validateCost(String? cost) {
    if (cost == null || cost.isEmpty)
      return 'An Expense should have a cost';
    else if (cost is int == false) return 'Expense cost should be a number';
    return null;
  }

  static String? validateCategory(String? id,
      {required List<ExpenseCategory> categories}) {
    if (id == null)
      return 'An Expense should have a category';
    else if (categories.isNotEmpty &&
        categories.indexWhere((element) => element.meta.id == id) < 0)
      return 'Invalid category, please select or create one';
    return null;
  }
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

  static ReceiptImage<NetworkImage> fromUrl(String url) {
    return ReceiptImage(type: RImageType.network, src: NetworkImage(url));
  }

  static ReceiptImage<FileImage> fromFile(File file) {
    return ReceiptImage(type: RImageType.file, src: FileImage(file));
  }

  static ReceiptImage<MemoryImage> fromMemory(Uint8List bytes) {
    return ReceiptImage(type: RImageType.memory, src: MemoryImage(bytes));
  }
}
