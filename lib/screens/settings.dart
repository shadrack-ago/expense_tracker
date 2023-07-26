import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
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
                              FutureBuilder(
                                future: instance.expenses,
                                builder: (context, snapshot) {
                                  return ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.data?.length ?? 0,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 10,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: ListTile(
                                          title: Text(
                                              snapshot.data?[index].name ?? ''),
                                          trailing: DropdownButton(
                                            items: [
                                              DropdownMenuItem(
                                                value: 1,
                                                onTap: () =>
                                                    Navigation.viewExpense(
                                                        context,
                                                        enabled: false,
                                                        expense: snapshot
                                                            .data?[index]),
                                                child: Row(children: [
                                                  Icon(Icons
                                                      .remove_red_eye_rounded),
                                                  SizedBox(width: 5),
                                                  Text('View expense')
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
                                                          color: Color(
                                                              0xff4d4639)),
                                                )
                                              ],
                                            ),
                                            onChanged: (value) {},
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              FutureBuilder(
                                  future: instance.categories,
                                  builder: (context, snapshot) {
                                    return ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot.data?.length ?? 0,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height: 10,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: ListTile(
                                            title: Text(
                                                snapshot.data?[index].name ??
                                                    ''),
                                            trailing: DropdownButton(
                                              items: [
                                                DropdownMenuItem(
                                                  value: 1,
                                                  onTap: () =>
                                                      Navigation.editCategory(
                                                          context,
                                                          category: snapshot
                                                              .data?[index]),
                                                  child: Row(children: [
                                                    Icon(Icons.edit_rounded),
                                                    SizedBox(width: 5),
                                                    Text('Edit category')
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
                                                            color: Color(
                                                                0xff4d4639)),
                                                  )
                                                ],
                                              ),
                                              onChanged: (value) {},
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  })
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
