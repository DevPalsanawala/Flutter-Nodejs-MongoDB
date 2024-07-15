import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/src/constants/color.dart';

class DAppbarTheme {
  DAppbarTheme._();

  static AppBarTheme lightAppbarTheme = AppBarTheme(
    backgroundColor: dPrimaryColor,
    elevation: 2,
    titleTextStyle: GoogleFonts.ubuntu(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
  static AppBarTheme darkAppbarTheme = AppBarTheme(
    backgroundColor: dSecondaryColor,
    elevation: 2,
    titleTextStyle: GoogleFonts.ubuntu(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}
