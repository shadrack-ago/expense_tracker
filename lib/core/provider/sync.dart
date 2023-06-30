import 'package:flutter/widgets.dart';

class SyncManager extends ChangeNotifier {
  SyncManager({required String docs, required String sheet})
      : _docs = docs,
        _sheet = sheet;

  /// Google forms data url
  String _docs = '';

  /// Google sheets ouput url
  String _sheet =
      '';

  String get docs => _docs;
  String get sheet => _sheet;

  void setSheet(String sheet) {
    _sheet = sheet;
    notifyListeners();
  }

  void setDocs(String docs) {
    _docs = docs;
    notifyListeners();
  }
}
