import '../router/index.dart';
import '../utils/extensions/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              '${GoRouter.of(context).location.substring(1).toCapitalized()}'),
          actions: [CircleAvatar()],
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          if (Breakpoints.of(context).isMobile()) {
            return child;
          }
          return Row(
            children: [
              NavigationRail(
                selectedIndex: 0,
                onDestinationSelected: (index) =>
                    context.go(MenuItem.items[index].route),
                destinations: MenuItem.items
                    .map((item) => NavigationRailDestination(
                        icon: Icon(item.icon), label: Text(item.name)))
                    .toList(),
              ),
              Expanded(child: child)
            ],
          );
        }),
        bottomNavigationBar: Breakpoints.of(context).isMobile()
            ? BottomNavigationBar(
                currentIndex: 0,
                onTap: (index) => context.go(MenuItem.items[index].route),
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
