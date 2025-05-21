import 'package:flutter/material.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';
import '../viewmodels/user_session.dart';
import '../models/user_model.dart';

class UserScore extends StatelessWidget {
  const UserScore({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel user = UserSession().currentUser!;
    final palette = Theme.of(context).extension<CustomPalette>()!;
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [palette.primary1000, palette.primary800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Position box
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: palette.warning50,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              '${user.position}\u00B0',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: palette.grey900,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: palette.grey0.withAlpha(128),
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(user.profileImage),
              ),
              const SizedBox(width: 12),
              Text(
                "Tu",
                style: appTextStyles.paragraphM.copyWith(color: palette.grey0),
              ),
            ],
          ),
          Container(
            width: 1,
            height: 40,
            color: palette.grey0.withAlpha(128),
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          Row(
            children: [
              Icon(Icons.emoji_events, color: palette.grey0, size: 26),
              const SizedBox(width: 6),
              Text(
                '${user.points} punti',
                style: appTextStyles.paragraphM.copyWith(color: palette.grey0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
