import 'package:flutter/material.dart';

import '../tools/custom_colors.dart';

class CustomDropdownMenu extends StatefulWidget {
  final String title;
  final List<String> items;
  final ValueChanged<String?>? onChanged; // Callback for selection change

  const CustomDropdownMenu({
    super.key,
    required this.title,
    required this.items,
    this.onChanged,
  });

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String? _selectedValue; // Local state to store the selected value

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(widget.title),
        value: _selectedValue,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: CustomColors.colorPrimary,
        ),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        underline: Container(
          height: 2,
          color: CustomColors.colorPrimary,
        ),
        onChanged: (String? newValue) {
          setState(() {
            _selectedValue = newValue;
          });
          widget.onChanged?.call(newValue);
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
