import 'package:flutter/material.dart';
import 'custom/rect_slider_thumb_shape.dart';
import '../utils/sizer.dart';

mixin RetipTheme {
  static const fontFamily = 'Play';

  static const primaryColor = Colors.lightBlue;

  static light([Color colorSchemeSeed = primaryColor]) => ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: colorSchemeSeed,
        fontFamily: fontFamily,
        iconButtonTheme: _iconButtonTheme,
        sliderTheme: sliderTheme,
      );

  static dark([Color colorSchemeSeed = primaryColor]) {
    final colorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: colorSchemeSeed,
    );

    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      fontFamily: fontFamily,
      iconButtonTheme: _iconButtonTheme,
      sliderTheme: sliderTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme(colorScheme),
      listTileTheme: _listTileThemeData(),
    );
  }

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

  static final _iconButtonTheme = IconButtonThemeData(
    style: ButtonStyle(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizer.x0_5),
        ),
      ),
    ),
  );

  static const sliderTheme = SliderThemeData(
    thumbShape: RectSliderThumbShape(),
    thumbColor: Colors.white,
    trackShape: RectangularSliderTrackShape(),
    trackHeight: Sizer.x0_5,
  );

  static _bottomNavigationBarTheme(ColorScheme colorScheme) {
    return BottomNavigationBarThemeData(
      unselectedItemColor: colorScheme.onSurface,
      selectedItemColor: colorScheme.onSurface,
      type: BottomNavigationBarType.shifting,
      showUnselectedLabels: true,
      showSelectedLabels: true,
    );
  }

  static ListTileThemeData _listTileThemeData() {
    return const ListTileThemeData(
      horizontalTitleGap: Sizer.x1,
      minTileHeight: Sizer.x7,
      minVerticalPadding: Sizer.x1,
      contentPadding: EdgeInsets.symmetric(horizontal: Sizer.x1),
    );
  }
}
