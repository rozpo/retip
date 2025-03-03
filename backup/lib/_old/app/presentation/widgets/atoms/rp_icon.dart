import 'package:flutter/material.dart';
import '../../../../core/utils/sizer.dart';

class RpIcon extends StatelessWidget {
  final IconData icon;

  const RpIcon({
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: Sizer.x5,
      height: Sizer.x5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizer.x0_5),
        color: theme.colorScheme.surfaceBright,
      ),
      child: Icon(icon),
    );
  }
}
