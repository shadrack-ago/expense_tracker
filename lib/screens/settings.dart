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
          Text(
            'Configure google forms and sheets sources',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Sheet url',
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Docs url',
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(onPressed: () {}, child: Text('Save Config'))
        ],
      ),
    );
  }
}
