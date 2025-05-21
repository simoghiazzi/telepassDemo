import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/constants/themes.dart';
import 'package:ghiazzi/repositories/sign_in_repository.dart';
import 'package:ghiazzi/router.dart';
import 'package:ghiazzi/viewmodels/signin_view_model.dart';

import 'package:ghiazzi/viewmodels/user_session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSession().restoreSession();
  runApp(
    BlocProvider<SigninViewModel>(
      create: (BuildContext context) => SigninViewModel(SigninRepository()),
      child: await initializeApp(),
    ),
  );
}

Future<Widget> initializeApp() async {
  final initialRoute = '/login';

  return Ghiazzi(initialRoute: initialRoute);
}

class Ghiazzi extends StatefulWidget {
  final String initialRoute;
  const Ghiazzi({super.key, required this.initialRoute});

  @override
  State<Ghiazzi> createState() => _GhiazziState();
}

class _GhiazziState extends State<Ghiazzi> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(initialRoute: widget.initialRoute);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ghiazzi - Telepass',
      themeMode:
          ThemeMode
              .light, // Use light theme by default as for this prototype only the light theme is defined
      theme: lightTheme,
      routerConfig: _appRouter.router,
    );
  }
}
