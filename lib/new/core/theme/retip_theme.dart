import 'package:flutter/material.dart';

class RetipTheme {
  static const _primaryColor = Colors.lightBlue;
  static const _fontFamily = 'Play';

  final light = ThemeData(
    fontFamily: _fontFamily,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: _primaryColor,
    ),
  );

  final dark = ThemeData(
    fontFamily: _fontFamily,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: _primaryColor,
    ),
  );

  final highContrastLight = ThemeData(
    colorScheme: const ColorScheme.highContrastLight(),
    brightness: Brightness.light,
  );

  final highContrastDark = ThemeData(
    colorScheme: const ColorScheme.highContrastDark(),
    brightness: Brightness.dark,
  );
}
