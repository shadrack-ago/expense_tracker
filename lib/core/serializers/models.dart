import '../models/expense.dart' show MetaData, RImageType, ReceiptImage;
import 'deserializer.dart';
import 'package:flutter/material.dart' hide MetaData;

extension RImageSerializer on ReceiptImage {
  Map<String, dynamic>? get serialized {
    switch (this.type) {
      case RImageType.file:
        return {
          'type': this.type,
          'data': this.data.serialized,
        };
      case RImageType.network:
        return {
          'type': this.type,
          'data': this.data.serialized,
        };
      case RImageType.memory:
        return {
          'type': this.type,
          'data': this.data.serialized,
        };
      default:
        return null;
    }
  }

  static ReceiptImage? deserialized(Map<String, dynamic> receiptObj) {
    switch (receiptObj['type']) {
      case RImageType.file:
        return ReceiptImage<FileImage>(
          type: receiptObj['type'],
          data: receiptObj['data'].deserialized,
        );
      case RImageType.network:
        return ReceiptImage<NetworkImage>(
          type: receiptObj['type'],
          data: receiptObj['data'].deserialized,
        );
      case RImageType.memory:
        return ReceiptImage<MemoryImage>(
          type: receiptObj['type'],
          data: receiptObj['data'].deserialized,
        );
      default:
        return null;
    }
  }
}

extension MetadataSerializer on MetaData {
  Map<String, dynamic> get serialized {
    return {'id': this.id, 'timeRecorded': this.timeRecorded};
  }

  static MetaData deserialized(Map<String, dynamic> metaObj) {
    return MetaData(
      id: metaObj['id'],
      timeRecorded: metaObj['timeRecorded'],
    );
  }
}
