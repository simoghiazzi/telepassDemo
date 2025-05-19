import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';

class CustomSearchBar extends StatelessWidget {
  final String label;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({super.key, required this.label, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;

    return Container(
      color: palette.primary800,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    label,
                    style: appTextStyles.displayL.copyWith(
                      color: palette.grey0,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Cerca",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: palette.grey50,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
