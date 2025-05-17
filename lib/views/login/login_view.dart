import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
          height: kToolbarHeight - 24, // Adjust height if necessary
        ),
        backgroundColor: palette.secondary,
      ),
      body: const Center(child: Text('Login View')),
    );
  }
}
