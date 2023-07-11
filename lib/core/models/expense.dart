import 'dart:io';
import 'dart:typed_data';

import 'package:expense_manager/core/models/category.dart';
import 'package:flutter/material.dart' hide MetaData;

class Expense {
  double cost;
  String name;
  MetaData meta;
  ReceiptImage? receiptData;

  /// This correlates to the category id.
  String categoryId;

  Expense({
    required this.meta,
    required this.name,
    required this.categoryId,
    required this.cost,
    this.receiptData,
  });
}

/// Holds Expense form data
class ExpenseForm {
  String name;
  String categoryId;
  double cost;
  ReceiptImage? receiptImage;
  ExpenseForm({
    required this.name,
    required this.categoryId,
    required this.cost,
    this.receiptImage,
  });

  /// Enables easy editing of given expense
  factory ExpenseForm.fromExpense(Expense data) {
    return ExpenseForm(
      name: data.name,
      categoryId: data.categoryId,
      cost: data.cost,
      receiptImage: data.receiptData,
    );
  }
}

class ExpenseValidator {
  static String? validateName(String? name) {
    if (name == null || name.isEmpty) return 'An Expense should have a name';
    return null;
  }

  static String? validateCost(String? cost) {
    if (cost == null || cost.isEmpty)
      return 'An Expense should have a cost';
    else if (int.tryParse(cost) == null)
      return 'Expense cost should be a number';
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

  static validateReceipt(String? value, RImageType? type) {
    if (type == RImageType.network &&
        !RegExp(r'^(https?:\/\/)').hasMatch(value ?? '')) {
      return 'Renaming url image is not supported, select image from camera or gallery to get the ability to rename it';
    }
    return null;
  }
}

class MetaData {
  DateTime timeRecorded;
  String id;

  MetaData({required this.id, required this.timeRecorded});

  factory MetaData.fromId(String id) {
    return MetaData(id: id, timeRecorded: DateTime.timestamp());
  }
}

/// Receipt image type
enum RImageType { network, memory, file }

class ReceiptImage<T> {
  RImageType type;
  T data;
  ReceiptImage({required this.type, required this.data});

  static ReceiptImage<NetworkImage> fromUrl(String url) {
    return ReceiptImage(type: RImageType.network, data: NetworkImage(url));
  }

  static ReceiptImage<FileImage> fromFile(File file) {
    return ReceiptImage(type: RImageType.file, data: FileImage(file));
  }

  static ReceiptImage<MemoryImage> fromMemory(Uint8List bytes) {
    return ReceiptImage(type: RImageType.memory, data: MemoryImage(bytes));
  }
}
