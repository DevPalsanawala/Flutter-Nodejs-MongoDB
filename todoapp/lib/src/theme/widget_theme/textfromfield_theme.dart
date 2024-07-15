import 'package:flutter/material.dart';
import 'package:todoapp/src/constants/color.dart';

class Dtextformfield {
  Dtextformfield._();
  static final InputDecorationTheme lightInputdecoration = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    prefixIconColor: dSecondaryColor,
    suffixIconColor: dSecondaryColor,
    floatingLabelStyle: const TextStyle(color: dPrimaryColor),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: dSecondaryColor, width: 2.0),
    ),
  );
  static final InputDecorationTheme darkInputdecoration = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    prefixIconColor: dPrimaryColor,
    suffixIconColor: dPrimaryColor,
    floatingLabelStyle: const TextStyle(color: dPrimaryColor),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: dPrimaryColor, width: 2.0),
    ),
  );
}
