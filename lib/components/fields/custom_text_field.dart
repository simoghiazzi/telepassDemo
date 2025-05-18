import 'package:flutter/material.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final String? initialValue;
  final bool enabled;
  final bool isPassword;
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final bool isChecked;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.initialValue,
    this.enabled = true,
    this.isPassword = false,
    this.placeholder,
    this.onChanged,
    this.isChecked = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;

  bool get _shouldFloatLabel =>
      _isFocused || widget.controller!.text.isNotEmpty;

  bool get _showPasswordButton => widget.enabled && widget.isPassword;

  late bool hideText;

  @override
  void initState() {
    super.initState();

    hideText = widget.isPassword;

    widget.controller!.text = widget.initialValue ?? '';
    _focusNode =
        FocusNode()
          ..addListener(() => setState(() => _isFocused = _focusNode.hasFocus));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;

    Color borderColor;
    Color labelColor;
    Color textColor;
    Color backgroundColor = Colors.transparent;

    if (!widget.enabled) {
      borderColor = palette.grey300;
      labelColor = palette.grey700;
      textColor = palette.grey600;
    } else if (_isFocused) {
      borderColor = palette.primary500;
      labelColor = palette.grey300;
      textColor = palette.grey900;
    } else {
      borderColor = palette.grey500;
      labelColor = palette.grey500;
      textColor = palette.grey700;
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        constraints: const BoxConstraints(minHeight: 72),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Main Column layout for label and text field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Floating Label
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style:
                      _shouldFloatLabel
                          ? appTextStyles.paragraphS.copyWith(color: labelColor)
                          : appTextStyles.paragraphM.copyWith(
                            color: labelColor,
                          ),
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.only(top: _shouldFloatLabel ? 0 : 22),
                    child: Text(widget.label),
                  ),
                ),
                const SizedBox(height: 6),
                // Expanded TextField to fill remaining space
                TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  style: appTextStyles.paragraphM.copyWith(color: textColor),
                  cursorColor:
                      palette
                          .primary500, //minLines and maxLines must be null when expands is true
                  obscureText: hideText,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: EdgeInsets.only(
                      right: _showPasswordButton ? 66 : 44,
                      top: 0,
                      bottom: 0,
                    ),
                    border: InputBorder.none,
                    hintText:
                        !_shouldFloatLabel ? (widget.placeholder ?? "") : null,
                    hintStyle: appTextStyles.paragraphM.copyWith(
                      color: palette.grey400,
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {});
                    widget.onChanged?.call(val);
                  },
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: Row(
                  children: [
                    if (widget.isChecked)
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: Icon(
                          Icons.check_circle_outline,
                          color: palette.success50,
                          size: 22,
                        ),
                      ),
                    if (_showPasswordButton)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            hideText = !hideText;
                          });
                        },
                        child: SizedBox(
                          width: 36,
                          height: 36,
                          child: Icon(
                            hideText
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: palette.grey400,
                            size: 22,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
