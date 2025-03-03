import 'package:flutter/material.dart';

class RetipTheme {
  static const String fontFamily = 'Play';
  static const Color primaryColor = Colors.blue;

  ThemeData get light => ThemeData(
        fontFamily: fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
        ),
      );

  ThemeData get dark => ThemeData(
        fontFamily: fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.dark,
        ),
      );
}
