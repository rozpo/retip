import 'package:flutter/material.dart';

class RetipTheme {
  static final Color _primaryColor = Colors.lightBlue;

  final ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: _primaryColor,
    ),
  );

  final ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: _primaryColor,
    ),
  );
}
