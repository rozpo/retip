import 'package:flutter/material.dart';

import '../atoms/text_widget.dart';

class ShufflePlayButtonsWidget extends StatelessWidget {
  final VoidCallback? onShuffleTap;
  final VoidCallback? onPlayTap;

  const ShufflePlayButtonsWidget({
    this.onShuffleTap,
    this.onPlayTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Expanded(
          child: FilledButton.icon(
            label: const TextWidget.short('Shuffle'),
            icon: const Icon(Icons.shuffle),
            onPressed: onShuffleTap,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: FilledButton.icon(
            label: const TextWidget.short('Play'),
            icon: const Icon(Icons.play_arrow),
            onPressed: onPlayTap,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
