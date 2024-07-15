import 'package:flutter/material.dart';
import 'package:todoapp/src/constants/color.dart';
import 'package:todoapp/src/constants/size.dart';

class DOutlineButtonTheme {
  DOutlineButtonTheme._();

  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      foregroundColor: dSecondaryColor,
      side: const BorderSide(
        color: dSecondaryColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: dButtonHeight),
    ),
  );

  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      foregroundColor: dPrimaryColor,
      side: const BorderSide(
        color: dPrimaryColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: dButtonHeight),
    ),
  );
}
