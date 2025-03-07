import 'package:flutter/material.dart';

class RetipTheme {
  static const fontFamily = 'Play';
  static const primaryColor = Colors.blue;

  ColorScheme colorScheme(Brightness brightness) {
    return ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: primaryColor,
    );
  }

  ThemeData dark() {
    final colors = colorScheme(Brightness.dark);

    return ThemeData(
      fontFamily: fontFamily,
      colorScheme: colors,
      outlinedButtonTheme: outlinedButtonTheme(),
      filledButtonTheme: filledButtonTheme(),
      textButtonTheme: textButtonTheme(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      bottomNavigationBarTheme: bottomNavigationBarTheme(colors),
    );
  }

  ThemeData light() {
    final colors = colorScheme(Brightness.light);

    return ThemeData(
      primaryColor: primaryColor,
      fontFamily: fontFamily,
      colorScheme: colors,
      outlinedButtonTheme: outlinedButtonTheme(),
      filledButtonTheme: filledButtonTheme(),
      textButtonTheme: textButtonTheme(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      bottomNavigationBarTheme: bottomNavigationBarTheme(colors),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );
  }

  FilledButtonThemeData filledButtonTheme() {
    return FilledButtonThemeData(style: buttonStyle());
  }

  TextButtonThemeData textButtonTheme() {
    return TextButtonThemeData(style: buttonStyle());
  }

  OutlinedButtonThemeData outlinedButtonTheme() {
    return OutlinedButtonThemeData(style: buttonStyle());
  }

  ScrollBehavior get scrollBehavior {
    return const ScrollBehavior().copyWith(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
    );
  }

  BottomNavigationBarThemeData bottomNavigationBarTheme(
      ColorScheme colorScheme) {
    return BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurface,
    );
  }
}
