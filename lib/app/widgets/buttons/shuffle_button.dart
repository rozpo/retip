import 'package:flutter/material.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class ShuffleButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ShuffleButton({
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      label: Text(
        RetipL10n.of(context).shuffle.toUpperCase(),
      ),
      icon: const Icon(Icons.shuffle),
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizer.x0_5)),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
