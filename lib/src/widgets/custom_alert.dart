import 'package:crmelinnovadorseller/src/tools/custom_colors.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';

class CustomAlert {
  static showMessage(BuildContext context, String titile, String message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(titile),
          titleTextStyle: const TextStyle(
            color: CustomColors.colorPrimary,
            fontFamily: 'Roboto',
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
          content: Text(message),
          contentTextStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          actions: [
            CustomButtons(
              onTap: () => Navigator.of(context).pop(),
              width: MediaQuery.of(context).size.width * .9,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 0.1),
              backgroundColor: CustomColors.colorPrimary,
              title: 'Atras',
              colorText: Colors.white,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              icon: const Icon(
                Icons.arrow_circle_left_rounded,
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
