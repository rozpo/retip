import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/audio/audio_bloc.dart';
import '../widgets/atoms/text_widget.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final audioBloc = context.read<AudioBloc>();

    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        final currentTrack = state.currentTrack;

        if (currentTrack == null) return const SizedBox();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Player'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget.short(currentTrack.title),
                if (currentTrack.artist != null)
                  TextWidget.short(currentTrack.artist!.name),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      style: Theme.of(context).iconButtonTheme.style,
                      icon: const Icon(
                        Icons.skip_previous,
                      ),
                      onPressed: () => audioBloc.add(AudioPrevious()),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filled(
                      style: Theme.of(context).iconButtonTheme.style,
                      icon: Icon(
                        state.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        state.isPlaying
                            ? audioBloc.add(AudioPause())
                            : audioBloc.add(AudioResume());
                      },
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      style: Theme.of(context).iconButtonTheme.style,
                      icon: const Icon(
                        Icons.skip_next,
                      ),
                      onPressed: () => audioBloc.add(AudioNext()),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
