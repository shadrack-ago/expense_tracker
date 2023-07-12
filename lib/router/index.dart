import 'package:expense_manager/core/models/category.dart';
import 'package:expense_manager/core/models/expense.dart';
import 'package:expense_manager/screens/add/category.dart';
import 'package:expense_manager/screens/add/expense.dart';
import 'package:expense_manager/utils/extensions/index.dart';

import '../layouts/index.dart';
import '../screens/home.dart';
import '../screens/insights.dart';
import '../screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navigation {
  static GlobalKey<NavigatorState> key = GlobalKey();
  final GoRouter router = GoRouter(
    navigatorKey: key,
    initialLocation: Routes.home.path,
    routes: [
      ShellRoute(
        builder: (context, state, child) => Layout(child: child),
        parentNavigatorKey: key,
        routes: routes
            .map(
              (r) => GoRoute(
                path: r.path,
                name: r.name,
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(15),
                      child: r.page,
                    ),
                  ),
                  transitionsBuilder: transition,
                  transitionDuration: transitionDuration,
                ),
              ),
            )
            .toList(),
      )
    ],
  );

  static List<_Route> routes = [Routes.home, Routes.insights, Routes.settings];

  static RouteTransitionsBuilder transition = (_, animation, __, child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  };

  static Duration transitionDuration = Duration(milliseconds: 250);

  static alert(
          {required BuildContext context, required WidgetBuilder builder}) =>
      showDialog(context: context, builder: builder);

  static addCategory(BuildContext context) {
    if (Breakpoints.of(context).isMobile()) {
      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return Scaffold(
            appBar: AppBar(title: Text(AddCategory.id.nomalized())),
            body: AddCategory(),
          );
        },
        transitionsBuilder: transition,
        transitionDuration: transitionDuration,
      ));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AddCategory.id.nomalized(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close),
                          )
                        ],
                      ),
                      Expanded(child: AddCategory()),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  static addExpense(BuildContext context) {
    if (Breakpoints.of(context).isMobile()) {
      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return Scaffold(
            appBar: AppBar(title: Text(AddExpense.id.nomalized())),
            body: AddExpense(),
          );
        },
        transitionsBuilder: transition,
        transitionDuration: transitionDuration,
      ));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AddExpense.id.nomalized(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close),
                          )
                        ],
                      ),
                      Expanded(child: AddExpense()),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  static editCategory(BuildContext context, {ExpenseCategory? category}) {
    if (Breakpoints.of(context).isMobile()) {
      Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return Scaffold(
            appBar: AppBar(title: Text('Edit Category')),
            body: AddCategory(category: category),
          );
        },
        transitionsBuilder: transition,
        transitionDuration: transitionDuration,
      ));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Edit Category',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close),
                          )
                        ],
                      ),
                      Expanded(child: AddCategory(category: category)),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  static editExpense(BuildContext context, {Expense? expense}) {
    if (Breakpoints.of(context).isMobile()) {
      Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return Scaffold(
            appBar: AppBar(title: Text('Edit Expense')),
            body: AddExpense(expense: expense),
          );
        },
        transitionsBuilder: transition,
        transitionDuration: transitionDuration,
      ));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Edit Expense',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close),
                          )
                        ],
                      ),
                      Expanded(child: AddExpense(expense: expense)),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}

class Routes {
  static _Route home = _Route(name: Home.id, path: '/${Home.id}', page: Home());
  static _Route insights =
      _Route(name: Insights.id, path: '/${Insights.id}', page: Insights());
  static _Route settings =
      _Route(name: Settings.id, path: '/${Settings.id}', page: Settings());
}

class _Route {
  String name;
  String path;
  Widget page;
  _Route({required this.name, required this.path, required this.page});
}
