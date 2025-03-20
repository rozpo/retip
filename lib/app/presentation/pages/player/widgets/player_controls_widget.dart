import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/audio/audio_bloc.dart';
import 'player_play_pause_widget.dart';

class PlayerControlsWidget extends StatelessWidget {
  const PlayerControlsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final audioBloc = context.read<AudioBloc>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.repeat)),
        Row(
          children: [
            IconButton.filledTonal(
              onPressed: () => audioBloc.add(AudioPrevious()),
              icon: const Icon(Icons.skip_previous),
            ),
            const SizedBox(width: 16),
            const PlayerPlayPauseWidget(),
            const SizedBox(width: 16),
            IconButton.filledTonal(
              onPressed: () => audioBloc.add(AudioNext()),
              icon: const Icon(Icons.skip_next),
            ),
          ],
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.shuffle)),
      ],
    );
  }
}
