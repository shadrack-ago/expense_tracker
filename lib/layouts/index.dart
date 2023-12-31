import 'package:expense_manager/utils/extensions/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/index.dart';

class Breakpoints {
  double tablet = 800;
  double handset = 500;

  BuildContext _context;
  Breakpoints({required BuildContext context}) : _context = context;
  static Breakpoints of(BuildContext context) {
    return Breakpoints(context: context);
  }

  bool isMobile() => MediaQuery.of(_context).size.shortestSide <= handset;
}

class MenuItem {
  String name;
  IconData icon;
  String route;
  MenuItem({required this.name, required this.icon, required this.route});

  static List<MenuItem> items = [
    MenuItem(
        name: 'Home', icon: Icons.home_max_rounded, route: Routes.home.path),
    MenuItem(
        name: 'Insights', icon: Icons.insights, route: Routes.insights.path),
    MenuItem(
        name: 'Settings', icon: Icons.settings, route: Routes.settings.path),
  ];
}

class Layout extends StatelessWidget {
  final Widget child;
  const Layout({super.key, required this.child});

  Widget? buildPageTitle(BuildContext context) {
    String location = GoRouter.of(context).location;
    if (location == Routes.insights.path) {
      return Text(Routes.insights.name.toCapitalized());
    } else if (location == Routes.settings.path) {
      return Text(Routes.settings.name.toCapitalized());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: buildPageTitle(context)),
      floatingActionButton: GoRouter.of(context).location == Routes.home.path
          ? FloatingActionButton.extended(
              label: Text(
                'Add Expense',
              ),
              icon: Icon(Icons.add_rounded),
              onPressed: () => Navigation.addExpense(context),
            )
          : null,
      body: LayoutBuilder(builder: (context, constraints) {
        if (Breakpoints.of(context).isMobile()) {
          return child;
        }
        return Row(
          children: [
            NavigationRail(
              selectedIndex: MenuItem.items.indexWhere(
                  (element) => element.route == GoRouter.of(context).location),
              onDestinationSelected: (index) =>
                  context.go(MenuItem.items[index].route),
              destinations: MenuItem.items
                  .map(
                    (item) => NavigationRailDestination(
                      icon: Tooltip(
                        verticalOffset: -13,
                        margin: EdgeInsets.only(left: 60),
                        triggerMode: TooltipTriggerMode.longPress,
                        waitDuration: Duration(seconds: 1),
                        child: Icon(item.icon),
                        message: item.name,
                      ),
                      label: Text(item.name),
                    ),
                  )
                  .toList(),
            ),
            Expanded(child: child)
          ],
        );
      }),
      bottomNavigationBar: Breakpoints.of(context).isMobile()
          ? BottomNavigationBar(
              currentIndex: MenuItem.items.indexWhere(
                  (element) => element.route == GoRouter.of(context).location),
              onTap: (index) => context.go(MenuItem.items[index].route),
              items: MenuItem.items
                  .map(
                    (item) => BottomNavigationBarItem(
                      icon: Icon(item.icon),
                      label: item.name,
                      tooltip: item.name,
                    ),
                  )
                  .toList(),
            )
          : null,
    );
  }
}
