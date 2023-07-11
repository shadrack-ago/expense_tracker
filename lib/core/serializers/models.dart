import 'package:expense_manager/core/models/expense.dart';

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

extension MetadataSerializer on MetaData {}
