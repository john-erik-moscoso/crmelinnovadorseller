import 'package:flutter/material.dart';

class CustomButtons extends StatefulWidget {
  final VoidCallback onTap;
  final double width;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color backgroundColor;
  final String title;
  final Color colorText;
  final double fontSize;
  final String fontFamily;
  final FontWeight fontWeight;
  final Icon icon;

  const CustomButtons({
    super.key,
    required this.onTap,
    required this.width,
    required this.padding,
    required this.margin,
    required this.backgroundColor,
    required this.title,
    required this.colorText,
    required this.fontSize,
    required this.fontFamily,
    required this.fontWeight,
    required this.icon,
  });

  @override
  State<CustomButtons> createState() => _CustomButtonsState();
}

class _CustomButtonsState extends State<CustomButtons> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        margin: widget.margin,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Titulo
            Text(
              widget.title,
              style: TextStyle(
                color: widget.colorText,
                fontSize: widget.fontSize,
                fontFamily: widget.fontFamily,
                fontWeight: widget.fontWeight,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            widget.icon,
          ],
        ),
      ),
    );
  }
}
