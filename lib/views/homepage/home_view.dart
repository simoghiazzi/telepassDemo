import 'package:flutter/material.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Inserisci le tue credenziali',
              style: appTextStyles.headingL,
              textAlign: TextAlign.left,
            ),
            Text(
              'per accedere al tuo account',
              style: appTextStyles.headingL,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ],
    );
  }
}
