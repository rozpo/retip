import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/audio/audio_bloc.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AudioBloc>();

    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              height: 1,
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: state.position.inSeconds,
                  child: Container(
                    height: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Expanded(
                  flex: state.duration.inSeconds - state.position.inSeconds,
                  child: Container(height: 0),
                ),
              ],
            ),
            ListTile(
              onTap: () {},
              leading: Container(
                color: Theme.of(context).colorScheme.surfaceContainer,
                width: 40,
                height: 40,
                child: const Icon(Icons.music_note),
              ),
              title: Text(state.currentTrack?.title ?? ''),
              subtitle: Text(state.currentTrack?.artist ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    style: Theme.of(context).iconButtonTheme.style,
                    icon: const Icon(
                      Icons.skip_previous,
                    ),
                    onPressed: () => bloc.add(AudioPrevious()),
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
                          ? bloc.add(AudioPause())
                          : bloc.add(AudioResume());
                    },
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    style: Theme.of(context).iconButtonTheme.style,
                    icon: const Icon(
                      Icons.skip_next,
                    ),
                    onPressed: () => bloc.add(AudioNext()),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
