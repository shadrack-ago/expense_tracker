import 'package:expense_manager/core/provider/sync.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  static const String id = 'settings';

  final _configFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SyncManager syncManager = Provider.of<SyncManager>(context);

    return Form(
      key: _configFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Configure forms and sheets sources',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 20),
          TextFormField(
            initialValue: syncManager.sheet,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Url is required';
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.dataset_linked_rounded),
              filled: true,
              label: Text('Sheet Url *'),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            initialValue: syncManager.docs,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Url is required';
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.document_scanner_rounded),
              filled: true,
              label: Text('Docs Url *'),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_configFormKey.currentState!.validate()) {
                Provider.of<SyncManager>(context, listen: false)
                    .updateUrl(sheet: '', docs: '');
              }
            },
            child: Text('Save Config'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 60),
            ),
          )
        ],
      ),
    );
  }
}
