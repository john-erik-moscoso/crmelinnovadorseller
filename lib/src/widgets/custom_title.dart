import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final String title;
  final double fontSize;
  final Color color;
  final String fontFamily;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const CustomTitle({
    super.key,
    this.padding,
    required this.title,
    required this.fontSize,
    required this.color,
    required this.fontFamily,
    required this.fontWeight,
    this.textAlign,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
        ),
        textAlign: textAlign ?? TextAlign.start,
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
    );
  }
}

class CustomDescription extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final String description;
  final double fontSize;
  final Color color;
  final String fontFamily;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int maxLines;
  final TextOverflow overflow;

  const CustomDescription({
    super.key,
    this.padding,
    required this.description,
    required this.fontSize,
    required this.color,
    required this.fontFamily,
    required this.fontWeight,
    required this.textAlign,
    required this.maxLines,
    required this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Text(
        description,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}
