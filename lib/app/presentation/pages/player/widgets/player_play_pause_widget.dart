import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/audio/audio_bloc.dart';

class PlayerPlayPauseWidget extends StatelessWidget {
  const PlayerPlayPauseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final audioBloc = context.read<AudioBloc>();

    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        final isPlaying = state.isPlaying;

        return IconButton.filled(
          iconSize: 30,
          onPressed: isPlaying
              ? () => audioBloc.add(AudioPause())
              : () => audioBloc.add(AudioResume()),
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
        );
      },
    );
  }
}
