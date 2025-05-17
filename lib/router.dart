import 'package:flutter/cupertino.dart';
import 'package:ghiazzi/views/login/login_view.dart';
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
          builder: (context, state) => const LoginView(),
        ),
      ],
    );
  }

  GoRouter get router => _router!;
}
