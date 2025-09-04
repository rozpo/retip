import 'package:flutter/material.dart';

class RetipTheme {
  static const _primaryColor = Colors.lightBlue;

  final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.light,
    ),
  );

  final dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark,
    ),
  );
}
