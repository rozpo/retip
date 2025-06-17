import 'package:flutter/material.dart';

class RetipTheme {
  static const _fontFamily = 'Play';
  static const _primaryColour = Color(0xFF04599C);

  final light = ThemeData(
    fontFamily: _fontFamily,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: _primaryColour,
    ),
  );

  final dark = ThemeData(
    fontFamily: _fontFamily,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: _primaryColour,
    ),
  );
}
