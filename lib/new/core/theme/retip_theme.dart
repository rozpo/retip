import 'package:flutter/material.dart';
import 'src/retip_button_theme.dart';

class RetipTheme {
  final RetipButtonTheme _retipButtonTheme;

  RetipTheme({
    required RetipButtonTheme retipButtonTheme,
  }) : _retipButtonTheme = retipButtonTheme;

  static const _fontFamily = 'Play';

  ThemeData light(Color primaryColor) {
    return ThemeData(
      filledButtonTheme: _retipButtonTheme.filledButtonThemeData(),
      outlinedButtonTheme: _retipButtonTheme.outlinedButtonThemeData(),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: primaryColor,
      ),
      brightness: Brightness.light,
      fontFamily: _fontFamily,
    );
  }

  ThemeData dark(Color primaryColor) {
    return ThemeData(
      filledButtonTheme: _retipButtonTheme.filledButtonThemeData(),
      outlinedButtonTheme: _retipButtonTheme.outlinedButtonThemeData(),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: primaryColor,
      ),
      brightness: Brightness.dark,
      fontFamily: _fontFamily,
    );
  }

  ThemeData get highContrastLight {
    return ThemeData(
      outlinedButtonTheme: _retipButtonTheme.outlinedButtonThemeData(),
      filledButtonTheme: _retipButtonTheme.filledButtonThemeData(),
      colorScheme: const ColorScheme.highContrastLight(),
      brightness: Brightness.light,
      fontFamily: _fontFamily,
    );
  }

  ThemeData get highContrastDark {
    return ThemeData(
      outlinedButtonTheme: _retipButtonTheme.outlinedButtonThemeData(),
      filledButtonTheme: _retipButtonTheme.filledButtonThemeData(),
      colorScheme: const ColorScheme.highContrastDark(),
      brightness: Brightness.dark,
      fontFamily: _fontFamily,
    );
  }
}
