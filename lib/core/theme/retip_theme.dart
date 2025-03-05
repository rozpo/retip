import 'package:flutter/material.dart';

class RetipTheme {
  static const fontFamily = 'Play';
  static const primaryColor = Colors.blue;

  ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: fontFamily,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: primaryColor,
      ),
    );
  }

  ThemeData light() {
    return ThemeData(
      primaryColor: primaryColor,
      fontFamily: fontFamily,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: primaryColor,
      ),
    );
  }
}
