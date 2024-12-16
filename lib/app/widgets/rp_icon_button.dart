import 'package:flutter/material.dart';

enum _RpIconButtonType {
  standard,
  filled,
  filledTonal,
  outlined,
}

class RpIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const RpIconButton({
    required this.icon,
    this.onPressed,
    super.key,
  }) : _type = _RpIconButtonType.standard;

  const RpIconButton.filled({
    required this.icon,
    this.onPressed,
    super.key,
  }) : _type = _RpIconButtonType.filled;

  const RpIconButton.filledTonal({
    required this.icon,
    this.onPressed,
    super.key,
  }) : _type = _RpIconButtonType.filledTonal;

  const RpIconButton.outlined({
    required this.icon,
    this.onPressed,
    super.key,
  }) : _type = _RpIconButtonType.outlined;

  final _RpIconButtonType _type;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).iconButtonTheme.style?.copyWith(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );

    switch (_type) {
      case _RpIconButtonType.standard:
        return IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          style: style,
        );
      case _RpIconButtonType.filled:
        return IconButton.filled(
          icon: Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: onPressed,
          style: style,
        );
      case _RpIconButtonType.filledTonal:
        return IconButton.filledTonal(
          icon: Icon(icon),
          onPressed: onPressed,
          style: style,
        );
      case _RpIconButtonType.outlined:
        return IconButton.outlined(
          icon: Icon(icon),
          onPressed: onPressed,
          style: style,
        );
    }
  }
}
