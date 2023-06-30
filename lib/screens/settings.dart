import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  static const String id = 'settings';

  final _configFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _configFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Configure google forms and sheets sources'),
          TextFormField(),
          SizedBox(height: 10),
          TextFormField(),
          SizedBox(height: 10),
          ElevatedButton(onPressed: () {}, child: Text('Save Config'))
        ],
      ),
    );
  }
}
