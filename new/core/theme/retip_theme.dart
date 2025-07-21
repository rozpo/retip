import 'package:flutter/material.dart';

class RetipTheme {
  static const _primaryColor = Colors.lightBlue;
  static const _fontFamily = 'Play';

  final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: _primaryColor,
    ),
    fontFamily: _fontFamily,
  );

  final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: _primaryColor,
    ),
    fontFamily: _fontFamily,
  );
}
