import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/repositories/faq_repository.dart';
import 'package:ghiazzi/repositories/notifications_repository.dart';
import 'package:ghiazzi/viewmodels/faq_view_model.dart';
import 'package:ghiazzi/viewmodels/notifications_view_model.dart';
import 'package:ghiazzi/views/courses/courses_view.dart';
import 'package:ghiazzi/views/homepage/home_view.dart';
import 'package:ghiazzi/views/login/signin_view.dart';
import 'package:ghiazzi/views/scaffold_with_navigation.dart';
import 'package:ghiazzi/views/wip/work_in_progress_view.dart';
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
            return MultiBlocProvider(
              providers: [
                BlocProvider<NotificationsViewModel>(
                  create:
                      (context) =>
                          NotificationsViewModel(NotificationsRepository()),
                ),
                BlocProvider<FaqViewModel>(
                  create: (context) => FaqViewModel(FaqRepository()),
                ),
              ],
              child: ScaffoldWithNavigation(
                navigationShell: navigationShell,
                state: state,
              ),
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
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: 'courses',
                  path: '/courses',
                  builder: (context, state) => const CoursesView(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: 'knowledge',
                  path: '/knowledge',
                  builder: (context, state) => const WorkInProgressView(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: 'profile',
                  path: '/profile',
                  builder: (context, state) => const WorkInProgressView(),
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
