import 'package:flutter/widgets.dart';

class SyncManager extends ChangeNotifier {
  /// Google forms data url
  String _docs =
      'https://docs.google.com/forms/d/e/1FAIpQLSfMUyXcKBHfNEM63qfAxZxq3SQDdRrQb49eKEs_TFpCDsKz7w/viewform?embedded=true';

  /// Google sheets ouput url
  String _sheet =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vSGbFtRPwKfGW2rxaWOo8d6zONVIaSTYDbrTRboCNIffzq6bm4bFNof5Rax5Z3QQWepAwZ4tbslEQLY/pubhtml';

  String get docs => _docs;
  String get sheet => _sheet;
}
