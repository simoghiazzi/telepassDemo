import 'package:flutter/material.dart';
import 'package:ghiazzi/components/reels/reel.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';
import 'package:ghiazzi/models/reel_model.dart';

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
              'Le novità del mondo Telepass',
              style: appTextStyles.headingL,
              textAlign: TextAlign.left,
            ),
            Text(
              'Rimani aggiornato su tutte le nostre attività',
              style: appTextStyles.headingS.copyWith(
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.left,
            ),
            Reel(
              reel: ReelModel(
                id: "1",
                title: "Test1",
                imageUrl: "assets/images/reels/test1.png",
                highlighted: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
