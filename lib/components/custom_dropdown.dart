import 'package:flutter/material.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';

class CustomDropdown extends StatefulWidget {
  final String title;
  final String content;
  final bool
  initiallyExpanded; //Used to open the first in the list as shown in the UI

  const CustomDropdown({
    super.key,
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: palette.primary100.withAlpha(100),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            ListTile(
              title: Text(widget.title, style: appTextStyles.headingS),
              trailing: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onTap: () => setState(() => _expanded = !_expanded),
            ),
            if (_expanded)
              Text(widget.content, style: appTextStyles.paragraphM),
          ],
        ),
      ),
    );
  }
}
