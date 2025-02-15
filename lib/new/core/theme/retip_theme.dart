import 'package:flutter/material.dart';
import 'package:retip/new/core/theme/src/button_theme.dart';

class RetipTheme {
  final RetipButtonTheme _retipButtonTheme;

  RetipTheme({
    required RetipButtonTheme retipButtonTheme,
  }) : _retipButtonTheme = retipButtonTheme;

  static const _primaryColor = Colors.lightBlue;
  static const _fontFamily = 'Play';

  ThemeData get light {
    return ThemeData(
      filledButtonTheme: _retipButtonTheme.filledButtonThemeData(),
      outlinedButtonTheme: _retipButtonTheme.outlinedButtonThemeData(),
      fontFamily: _fontFamily,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: _primaryColor,
      ),
    );
  }

  ThemeData dark(Color primaryColor) {
    return ThemeData(
      filledButtonTheme: _retipButtonTheme.filledButtonThemeData(),
      outlinedButtonTheme: _retipButtonTheme.outlinedButtonThemeData(),
      fontFamily: _fontFamily,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: primaryColor,
      ),
    );
  }

  ThemeData get highContrastLight {
    return ThemeData(
      filledButtonTheme: _retipButtonTheme.filledButtonThemeData(),
      outlinedButtonTheme: _retipButtonTheme.outlinedButtonThemeData(),
      colorScheme: const ColorScheme.highContrastLight(),
      brightness: Brightness.light,
    );
  }

  ThemeData get highContrastDark {
    return ThemeData(
      filledButtonTheme: _retipButtonTheme.filledButtonThemeData(),
      outlinedButtonTheme: _retipButtonTheme.outlinedButtonThemeData(),
      colorScheme: const ColorScheme.highContrastDark(),
      brightness: Brightness.dark,
    );
  }
}
