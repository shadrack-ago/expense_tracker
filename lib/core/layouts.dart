import 'package:expense_manager/core/router.dart';
import 'package:flutter/material.dart';

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
    MenuItem(name: 'Home', icon: Icons.home_max_rounded, route: Routes.home),
    MenuItem(name: 'Insights', icon: Icons.insights, route: Routes.insights),
    MenuItem(name: 'Settings', icon: Icons.settings, route: Routes.settings),
  ];
}

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${ModalRoute.of(context)?.settings.name}'),
          actions: [CircleAvatar()],
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          if (Breakpoints.of(context).isMobile()) {
            return Navigation.navigator;
          }
          return Row(
            children: [
              NavigationRail(
                selectedIndex: 0,
                onDestinationSelected: (index) => Navigation.router.currentState
                    ?.pushNamed(MenuItem.items[index].route),
                destinations: MenuItem.items
                    .map((item) => NavigationRailDestination(
                        icon: Icon(item.icon), label: Text(item.name)))
                    .toList(),
              ),
              Expanded(child: Navigation.navigator)
            ],
          );
        }),
        bottomNavigationBar: Breakpoints.of(context).isMobile()
            ? BottomNavigationBar(
                currentIndex: 0,
                onTap: (index) => Navigation.router.currentState
                    ?.pushNamed(MenuItem.items[index].route),
                items: MenuItem.items
                    .map((item) => BottomNavigationBarItem(
                        icon: Icon(item.icon), label: item.name))
                    .toList(),
              )
            : null,
      ),
    );
  }
}
