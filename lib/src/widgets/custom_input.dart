import 'package:crmelinnovadorseller/src/tools/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Color fillColor;
  final String title;
  final Icon icon;

  const CustomInput({
    super.key,
    this.padding,
    this.margin,
    this.width,
    required this.controller,
    required this.obscureText,
    required this.keyboardType,
    required this.fillColor,
    required this.title,
    required this.icon,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ??
          const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: widget.width ?? MediaQuery.of(context).size.width * .9,
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.merge(
              const BorderSide(color: CustomColors.colorPrimary, width: 0.3),
              const BorderSide(color: CustomColors.colorPrimary, width: 0.3),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: widget.fillColor,
          hintText: widget.title,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: widget.icon,
          counterStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
