import 'package:flutter/widgets.dart';

class SyncManager extends ChangeNotifier {
  /// Google forms data url
  String _docs = 'https://forms.gle/znhV2TDzTXY1zk9p6';

  /// Google sheets ouput url
  String _sheet =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vSGbFtRPwKfGW2rxaWOo8d6zONVIaSTYDbrTRboCNIffzq6bm4bFNof5Rax5Z3QQWepAwZ4tbslEQLY/pubhtml';

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
