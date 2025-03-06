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
      outlinedButtonTheme: outlinedButtonTheme(),
      filledButtonTheme: filledButtonTheme(),
      textButtonTheme: textButtonTheme(),
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
      outlinedButtonTheme: outlinedButtonTheme(),
      filledButtonTheme: filledButtonTheme(),
      textButtonTheme: textButtonTheme(),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  FilledButtonThemeData filledButtonTheme() {
    return FilledButtonThemeData(style: buttonStyle());
  }

  TextButtonThemeData textButtonTheme() {
    return TextButtonThemeData(style: buttonStyle());
  }

  OutlinedButtonThemeData outlinedButtonTheme() {
    return OutlinedButtonThemeData(style: buttonStyle());
  }
}
