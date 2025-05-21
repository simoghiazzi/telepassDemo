import 'package:flutter/material.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';

class WorkInProgressView extends StatelessWidget {
  const WorkInProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isBounded =
            constraints.hasBoundedHeight &&
            constraints.maxHeight < double.infinity;
        final child = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Work in progress',
                style: appTextStyles.displayL.copyWith(
                  color: palette.primary800,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
        if (isBounded) {
          return SizedBox.expand(child: child);
        } else {
          // Unbounded, e.g. inside a scroll view ---> Just move it a bit below the top
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 160.0),
            child: child,
          );
        }
      },
    );
  }
}
