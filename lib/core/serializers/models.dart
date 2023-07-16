import 'dart:io';
import 'dart:typed_data';

import '../models/expense.dart' show MetaData, RImageType, ReceiptImage;
import 'package:flutter/material.dart' hide MetaData;

extension RImageSerializer on ReceiptImage {
  Map<String, dynamic>? get serialized {
    switch (this.type) {
      case RImageType.file:
        return {
          'type': this.type.serialized,
          'name': this.name,
          'data': ImageSerialization.fromFile(this.data),
        };
      case RImageType.network:
        return {
          'type': this.type.serialized,
          'name': this.name,
          'data': ImageSerialization.fromNetwork(this.data),
        };
      case RImageType.memory:
        return {
          'type': this.type.serialized,
          'name': this.name,
          'data': ImageSerialization.fromMemory(this.data),
        };
      default:
        return null;
    }
  }

  static ReceiptImage? deserialized(Map<String, dynamic>? receiptObj) {
    if (receiptObj != null) {
      var type = EnumSerialization.deserialized(receiptObj['type']);

      switch (type) {
        case RImageType.file:
          return ReceiptImage<FileImage>(
            type: EnumSerialization.deserialized(receiptObj['type']),
            name: receiptObj['name'],
            data: ImageSerialization.toFile(receiptObj['data']),
          );
        case RImageType.network:
          return ReceiptImage<NetworkImage>(
            type: EnumSerialization.deserialized(receiptObj['type']),
            name: receiptObj['name'],
            data: ImageSerialization.toNetwork(receiptObj['data']),
          );
        case RImageType.memory:
          return ReceiptImage<MemoryImage>(
            type: EnumSerialization.deserialized(receiptObj['type']),
            name: receiptObj['name'],
            data: ImageSerialization.toMemory(receiptObj['data']),
          );
        default:
          return null;
      }
    }
    return null;
  }
}

extension EnumSerialization on RImageType {
  String get serialized {
    return this.toString();
  }

  static RImageType deserialized(String value) {
    return RImageType.values.firstWhere((e) {
      return e.toString() == value;
    });
  }
}

extension ImageSerialization on dynamic {
  /// From JSON to file Image
  static FileImage toFile(Map<String, dynamic> data) {
    return FileImage(File.fromUri(data['raw']));
  }

  /// From JSON to network Image
  static NetworkImage toNetwork(Map<String, dynamic> data) {
    return NetworkImage(data['raw']);
  }

  /// From JSON to memory Image
  static MemoryImage toMemory(Map<String, dynamic> data) {
    return MemoryImage(data['raw']);
  }

  /// From fileImage to JSON
  static Map<String, dynamic> fromFile(FileImage file) {
    return {'raw': file.file.uri};
  }

  /// From networkImage to JSON
  static Map<String, dynamic> fromNetwork(NetworkImage file) {
    return {'raw': file.url};
  }

  /// From memoryImage to JSON
  static Map<String, dynamic> fromMemory(MemoryImage file) {
    return {'raw': file.bytes};
  }
}

extension MetadataSerializer on MetaData {
  Map<String, dynamic> get serialized {
    return {'id': this.id, 'timeRecorded': this.timeRecorded.toIso8601String()};
  }

  static MetaData deserialized(Map<String, dynamic> metaObj) {
    return MetaData(
      id: metaObj['id'],
      timeRecorded: DateTime.parse(metaObj['timeRecorded']),
    );
  }
}
