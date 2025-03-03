import 'package:flutter/material.dart';

class IconButtonAtom extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData iconData;

  const IconButtonAtom({
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
