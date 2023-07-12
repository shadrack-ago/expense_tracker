import 'package:expense_manager/router/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/provider/manager.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  static const String id = 'settings';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Edit properties',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 16 / 20,
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(tabs: [
                        Tooltip(
                          preferBelow: false,
                          message: 'Expenses',
                          child: Tab(
                            text: 'Expenses',
                          ),
                        ),
                        Tooltip(
                          preferBelow: false,
                          message: 'Categories',
                          child: Tab(
                            text: 'Categories',
                          ),
                        ),
                      ]),
                      SizedBox(height: 12),
                      AspectRatio(
                        aspectRatio: 16 / 4,
                        child: Consumer<DataManager>(
                          builder: (context, instance, child) {
                            return TabBarView(children: [
                              ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemCount: instance.expenses.length,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      title:
                                          Text(instance.expenses[index].name),
                                      trailing: DropdownButton(
                                        items: [
                                          DropdownMenuItem(
                                            value: 1,
                                            onTap: () => Navigation.editExpense(
                                                context,
                                                expense:
                                                    instance.expenses[index]),
                                            child: TextButton.icon(
                                                onPressed: () {},
                                                icon: Icon(Icons.edit_rounded),
                                                label: Text('Edit expense')),
                                          ),
                                          DropdownMenuItem(
                                            value: 1,
                                            onTap: () => instance.deleteExpense(
                                                id: instance
                                                    .expenses[index].meta.id),
                                            child: TextButton.icon(
                                                style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.redAccent),
                                                onPressed: () {},
                                                icon:
                                                    Icon(Icons.delete_rounded),
                                                label: Text('Delete expense')),
                                          ),
                                        ],
                                        hint: ElevatedButton(
                                          onPressed: () {},
                                          child: Icon(Icons.more_horiz),
                                        ),
                                        onChanged: (value) {},
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemCount: instance.categories.length,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      title:
                                          Text(instance.categories[index].name),
                                      trailing: Text(''),
                                    ),
                                  );
                                },
                              )
                            ]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
