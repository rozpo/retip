import 'package:flutter/material.dart';

class RetipTheme {
  static const primaryColor = Colors.lightBlue;
  static const _fontFamily = 'Play';

  ThemeData light([Color? color]) => ThemeData(
    fontFamily: _fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: color ?? primaryColor,
      brightness: Brightness.light,
    ),
  );

  ThemeData dark([Color? color]) => ThemeData(
    fontFamily: _fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: color ?? primaryColor,
      brightness: Brightness.dark,
    ),
  );
}
