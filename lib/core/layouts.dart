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

class FormFactor {}

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
            return Navigator(
              key: Navigation.router,
              onGenerateRoute: Navigation.generateRoute,
            );
          }
          return Row(
            children: [
              NavigationRail(destinations: [
                NavigationRailDestination(
                    icon: Icon(Icons.home_max_rounded), label: Text('Home')),
                NavigationRailDestination(
                    icon: Icon(Icons.insights), label: Text('Insights')),
                NavigationRailDestination(
                    icon: Icon(Icons.settings), label: Text('Settings')),
              ], selectedIndex: 0),
              Expanded(
                child: Navigator(
                  key: Navigation.router,
                  onGenerateRoute: Navigation.generateRoute,
                ),
              )
            ],
          );
        }),
        bottomNavigationBar: Breakpoints.of(context).isMobile()
            ? BottomNavigationBar(items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_max_rounded), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.insights), label: 'Insights'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ])
            : null,
      ),
    );
  }
}
