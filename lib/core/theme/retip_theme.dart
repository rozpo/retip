import 'package:flutter/material.dart';

mixin RetipTheme {
  static const fontFamily = 'Play';

  static final light = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: Colors.blue,
    fontFamily: fontFamily,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.blue,
    fontFamily: fontFamily,
  );

  static final contrastLight = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: Colors.black,
    fontFamily: fontFamily,
  );

  static final contrastDark = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.white,
    fontFamily: fontFamily,
  );
}
