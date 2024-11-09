import 'package:flutter/material.dart';
import 'package:retip/core/utils/sizer.dart';

class PlayButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const PlayButton({
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      label: const Text('Play'),
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
