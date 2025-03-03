import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/sizer.dart';
import '../../../../domain/repositories/audio_repository.dart';
import 'play_pause_icon.dart';

class PlaybackButtons extends StatelessWidget {
  const PlaybackButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<AudioRepository>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StreamBuilder<bool>(
          stream: repository.shuffleModeStream,
          builder: (context, snapshot) {
            final enabled = snapshot.data ?? false;

            return IconButton(
              onPressed: () => repository.setShuffleMode(!enabled),
              icon: Icon(
                Icons.shuffle,
                color: enabled
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
            );
          },
        ),
        IconButton.filledTonal(
          onPressed: () => repository.skipToPrevious(),
          icon: const Icon(Icons.skip_previous),
        ),
        const PlayPauseIcon(size: Sizer.x5),
        IconButton.filledTonal(
          onPressed: () => repository.skipToNext(),
          icon: const Icon(Icons.skip_next),
        ),
        StreamBuilder<AudioRepeatMode>(
          stream: repository.repeatModeStream,
          builder: (context, snapshot) {
            final loopMode = snapshot.data ?? AudioRepeatMode.none;
            final index = AudioRepeatMode.values.indexOf(loopMode) + 1;
            final nextIndex =
                index >= AudioRepeatMode.values.length ? 0 : index;
            final nextLoopMode = AudioRepeatMode.values[nextIndex];

            final IconData iconData;
            final Color iconColor;
            switch (loopMode) {
              case AudioRepeatMode.all:
                iconData = Icons.repeat_on;
                iconColor = Theme.of(context).colorScheme.primary;
                break;
              case AudioRepeatMode.one:
                iconData = Icons.repeat_one_on_sharp;
                iconColor = Theme.of(context).colorScheme.primary;
                break;
              case AudioRepeatMode.none:
                iconData = Icons.repeat;
                iconColor = Theme.of(context).colorScheme.onSurface;
                break;
            }

            return IconButton(
              onPressed: () => repository.setRepeatMode(nextLoopMode),
              icon: Icon(
                iconData,
                color: iconColor,
              ),
            );
          },
        ),
      ],
    );
  }
}
