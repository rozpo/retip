import 'package:flutter/material.dart';
import 'package:retip/core/theme/custom/rect_slider_thumb_shape.dart';
import 'package:retip/core/utils/sizer.dart';

mixin RetipTheme {
  static const fontFamily = 'Play';

  static const primaryColor = Colors.lightBlue;

  static light([Color colorSchemeSeed = primaryColor]) => ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: colorSchemeSeed,
        fontFamily: fontFamily,
        iconButtonTheme: iconButtonFilled,
        sliderTheme: sliderTheme,
      );

  static dark([Color colorSchemeSeed = primaryColor]) => ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: colorSchemeSeed,
        fontFamily: fontFamily,
        iconButtonTheme: iconButtonFilled,
        sliderTheme: sliderTheme,
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

  static final iconButtonFilled = IconButtonThemeData(
    style: ButtonStyle(
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

  static const iconButtonStyle = ButtonStyle(
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}
