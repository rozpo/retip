import 'package:flutter/material.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({
    super.leading,
    super.title,
    super.actions,
    super.bottom,
    super.key,
  }) : super(
          titleSpacing: 0,
        );
}
