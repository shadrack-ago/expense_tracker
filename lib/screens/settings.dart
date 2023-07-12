import 'package:expense_manager/router/index.dart';
import 'package:expense_manager/utils/extensions/context.dart';
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
                                            child: Row(children: [
                                              Icon(Icons.edit_rounded),
                                              SizedBox(width: 5),
                                              Text('Edit expense')
                                            ]),
                                          ),
                                          DropdownMenuItem(
                                            value: 1,
                                            onTap: () => instance.deleteExpense(
                                                id: instance
                                                    .expenses[index].meta.id),
                                            child: Row(children: [
                                              Icon(
                                                Icons.delete_rounded,
                                                color: Colors.redAccent,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                'Delete expense',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        color:
                                                            Colors.redAccent),
                                              )
                                            ]),
                                          ),
                                        ],
                                        hint: Row(
                                          children: [
                                            Icon(Icons.more_horiz),
                                            SizedBox(width: 5),
                                            Text(
                                              'Options',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      color: Color(0xff4d4639)),
                                            )
                                          ],
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
                                      trailing: DropdownButton(
                                        items: [
                                          DropdownMenuItem(
                                            value: 1,
                                            onTap: () =>
                                                Navigation.editCategory(context,
                                                    category: instance
                                                        .categories[index]),
                                            child: Row(children: [
                                              Icon(Icons.edit_rounded),
                                              SizedBox(width: 5),
                                              Text('Edit category')
                                            ]),
                                          ),
                                          DropdownMenuItem(
                                            value: 1,
                                            onTap: () => instance
                                                .deleteCategory(
                                                    id: instance
                                                        .categories[index]
                                                        .meta
                                                        .id)
                                                .then(
                                                  (message) => context
                                                      .showSnackbar(message),
                                                )
                                                .onError((String message,
                                                        stackTrace) =>
                                                    context
                                                        .showSnackbar(message)),
                                            child: Row(children: [
                                              Icon(
                                                Icons.delete_rounded,
                                                color: Colors.redAccent,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                'Delete category',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        color:
                                                            Colors.redAccent),
                                              )
                                            ]),
                                          ),
                                        ],
                                        hint: Row(
                                          children: [
                                            Icon(Icons.more_horiz),
                                            SizedBox(width: 5),
                                            Text(
                                              'Options',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      color: Color(0xff4d4639)),
                                            )
                                          ],
                                        ),
                                        onChanged: (value) {},
                                      ),
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
