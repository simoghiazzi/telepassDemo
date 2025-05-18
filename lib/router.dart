import 'package:flutter/cupertino.dart';
import 'package:ghiazzi/views/homepage/home_view.dart';
import 'package:ghiazzi/views/login/signin_view.dart';
import 'package:ghiazzi/views/scaffold_with_navigation.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final String initialRoute;

  static GoRouter? _router;

  AppRouter({required this.initialRoute}) {
    final rootNavigatorKey = GlobalKey<NavigatorState>();

    _router ??= GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: initialRoute,
      routes: [
        GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) => const SigninView(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            // Return the widget that implements the custom shell (e.g a BottomNavigationBar).
            // The [StatefulNavigationShell] is passed to be able to navigate to other branches in a stateful way.
            return ScaffoldWithNavigation(
              navigationShell: navigationShell,
              state: state,
            );
          },
          branches: [
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: '/home',
                  builder: (context, state) => const HomeView(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  GoRouter get router => _router!;
}
