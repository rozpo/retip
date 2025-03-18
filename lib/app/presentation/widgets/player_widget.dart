import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_routes.dart';
import '../blocs/audio/audio_bloc.dart';
import '../blocs/track/track_bloc.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final audioBloc = context.read<AudioBloc>();
    final trackBloc = context.read<TrackBloc>();

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
            if (state.currentTrack != null) ...[
              ListTile(
                onTap: () => context.push(RetipRoutes.player),
                leading: Container(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.music_note),
                ),
                title: Text(
                  state.currentTrack?.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  state.currentTrack?.artist?.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      style: Theme.of(context).iconButtonTheme.style,
                      icon: Icon(
                        state.currentTrack?.isFavorite == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      onPressed: () {
                        if (state.currentTrack == null) return;
                        trackBloc.add(TrackToggleFavorite(state.currentTrack!));
                      },
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
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
