import 'package:flutter/material.dart';

class RetipTheme {
  static const Color _primaryColor = Colors.lightBlue;
  static const String _fontFamily = 'Play';

  ThemeData get darkTheme {
    return ThemeData(
      fontFamily: _fontFamily,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: _primaryColor,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: ContinuousRectangleBorder(),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.all(8),
        minVerticalPadding: 0,
        minTileHeight: 40,
        horizontalTitleGap: 8,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  ScrollBehavior get scrollBehavior {
    return const ScrollBehavior().copyWith(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
