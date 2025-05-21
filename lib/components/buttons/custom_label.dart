import 'package:flutter/material.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';

class CustomLabel extends StatelessWidget {
  final List<String> labels;
  final String selected;
  final void Function(String) onSelected;

  const CustomLabel({
    super.key,
    required this.labels,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;

    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:
            labels.map((label) {
              final bool isActive = label == selected;
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 4 : 8,
                ),
                child: GestureDetector(
                  onTap: () => onSelected(label),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 10 : 18,
                      vertical: isSmallScreen ? 6 : 10,
                    ),
                    decoration: BoxDecoration(
                      color: isActive ? palette.primary800 : palette.grey50,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isActive ? palette.primary800 : palette.grey900,
                      ),
                    ),
                    child: Text(
                      label[0].toUpperCase() + label.substring(1),
                      style: appTextStyles.ctaM.copyWith(
                        color: isActive ? palette.grey0 : palette.grey900,
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.normal,
                        fontSize:
                            isSmallScreen ? 13 : appTextStyles.ctaM.fontSize,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
