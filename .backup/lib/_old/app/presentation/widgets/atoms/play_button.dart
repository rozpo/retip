import 'package:flutter/material.dart';
import '../../../../core/l10n/retip_l10n.dart';
import '../../../../core/utils/sizer.dart';

class PlayButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const PlayButton({
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      label: Text(
        RetipL10n.of(context).play.toUpperCase(),
      ),
      icon: const Icon(Icons.play_arrow),
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
