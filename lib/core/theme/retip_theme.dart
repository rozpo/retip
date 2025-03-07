import 'package:flutter/material.dart';

class RetipTheme {
  static const fontFamily = 'Play';
  static const primaryColor = Colors.blue;

  ColorScheme colorScheme(Brightness brightness) {
    return ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: brightness,
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
      iconButtonTheme: iconButtonTheme(colors),
      snackBarTheme: snackBarTheme(colors),
      listTileTheme: listTileTheme(colors),
    );
  }

  ThemeData light() {
    final colors = colorScheme(Brightness.light);

    return ThemeData(
      fontFamily: fontFamily,
      colorScheme: colors,
      outlinedButtonTheme: outlinedButtonTheme(),
      filledButtonTheme: filledButtonTheme(),
      textButtonTheme: textButtonTheme(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      bottomNavigationBarTheme: bottomNavigationBarTheme(colors),
      iconButtonTheme: iconButtonTheme(colors),
      snackBarTheme: snackBarTheme(colors),
      listTileTheme: listTileTheme(colors),
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
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurface,
    );
  }

  TabBarTheme tabBarTheme(ColorScheme colorScheme) {
    return TabBarTheme(
      labelColor: colorScheme.primary,
      unselectedLabelColor: colorScheme.onSurface,
    );
  }

  SnackBarThemeData snackBarTheme(ColorScheme colorScheme) {
    return SnackBarThemeData(
      backgroundColor: colorScheme.surfaceContainer,
      behavior: SnackBarBehavior.fixed,
    );
  }

  ListTileThemeData listTileTheme(ColorScheme colorScheme) {
    return const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      shape: BeveledRectangleBorder(),
      minTileHeight: 40,
      minVerticalPadding: 8,
      horizontalTitleGap: 16,
    );
  }

  IconButtonThemeData iconButtonTheme(ColorScheme colorScheme) {
    return IconButtonThemeData(style: buttonStyle());
  }
}
