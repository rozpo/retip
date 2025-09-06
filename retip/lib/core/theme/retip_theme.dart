import 'package:flutter/material.dart';

class RetipTheme {
  static const _primaryColor = Colors.lightBlue;
  static const _fontFamily = 'Play';

  final light = ThemeData(
    fontFamily: _fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.light,
    ),
  );

  final dark = ThemeData(
    fontFamily: _fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark,
    ),
  );
}
