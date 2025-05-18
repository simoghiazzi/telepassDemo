import 'package:flutter/material.dart';
import 'package:ghiazzi/constants/colors.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool checked = true;

  @override
  Widget build(BuildContext context) {
    final bool checked = widget.value;
    final palette = Theme.of(context).extension<CustomPalette>()!;

    return Checkbox(
      value: checked,
      onChanged: (value) => widget.onChanged(value ?? false),
      activeColor: palette.primary800,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}
