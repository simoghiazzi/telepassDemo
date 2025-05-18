import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;
  final bool isActive;
  final FontWeight fontWeight;
  final IconData? leadingIcon;
  final TextStyle textStyle;
  final MainAxisAlignment alignment;
  final double verticalPadding;

  const CustomTextButton({
    super.key,
    required this.title,
    required this.color,
    required this.onPressed,
    this.isActive = true,
    this.fontWeight = FontWeight.normal,
    this.leadingIcon,
    this.textStyle = const TextStyle(),
    this.alignment = MainAxisAlignment.start,
    this.verticalPadding = 0,
  });

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isActive ? widget.onPressed : null,
      child: Container(
        decoration: BoxDecoration(
          color: widget.isActive ? widget.color : widget.color.withAlpha(160),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: widget.alignment,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: widget.verticalPadding,
              ),
              child: Center(child: Text(widget.title, style: widget.textStyle)),
            ),
            widget.leadingIcon != null
                ? Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: Icon(
                      widget.leadingIcon!,
                      color: Colors.white,
                      size: 17,
                    ),
                  ),
                )
                : Container(),
          ],
        ),
      ),
    );
  }
}
