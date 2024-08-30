import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:crmelinnovadorseller/src/tools/custom_colors.dart';

class CustomCardImage extends StatefulWidget {
  final IconData icon;
  final String title;
  final List<String>? interest;

  const CustomCardImage({
    super.key,
    required this.icon,
    required this.title,
    this.interest,
  });

  @override
  State<CustomCardImage> createState() => _CustomCardImageState();
}

class _CustomCardImageState extends State<CustomCardImage> {
  late bool isSelected = false;

  void _onCheckboxChanged(bool? value) {
    setState(() {
      isSelected = value ?? false;
      if (isSelected) {
        widget.interest?.add(widget.title);
        debugPrint(
          'ELEMENTO INSERTADO ${widget.title.toString().toUpperCase()}',
        );
        debugPrint(
          'ELEMENTOS DE LA LISTA ${widget.interest.toString().toUpperCase()}',
        );
      } else {
        widget.interest?.remove(widget.title);
        debugPrint(
          'ELEMENTO ELIMINADO ${widget.title.toString().toUpperCase()}',
        );
        debugPrint(
          'ELEMENTOS DE LA LISTA ${widget.interest.toString().toUpperCase()}',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HugeIcon(
            icon: widget.icon,
            color: CustomColors.colorPrimary,
            size: 28.0,
          ),
          const SizedBox(height: 6),
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: CustomColors.colorPrimary,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          Flexible(
            child: Checkbox(
              value: isSelected,
              onChanged: _onCheckboxChanged,
              activeColor: CustomColors.colorPrimary,
              checkColor: Colors.white,
              focusColor: CustomColors.colorPrimary,
              hoverColor: CustomColors.colorPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
