import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData iconData;

  const IconButtonWidget({
    required this.iconData,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: Theme.of(context).iconButtonTheme.style,
      icon: Icon(iconData),
      onPressed: onPressed,
    );
  }
}
