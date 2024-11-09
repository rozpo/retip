import 'package:flutter/material.dart';

class RpAppBar extends AppBar {
  RpAppBar({
    super.leading,
    super.title,
    super.actions,
    super.key,
  }) : super(
          titleSpacing: 0,
        );
}
