import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/audio/audio_bloc.dart';
import '../blocs/track/track_bloc.dart';

class TracksView extends StatelessWidget {
  const TracksView({super.key});

  @override
  Widget build(BuildContext context) {
    final audioBloc = BlocProvider.of<AudioBloc>(context);
    final trackBloc = BlocProvider.of<TrackBloc>(context);

    return BlocBuilder<TrackBloc, TrackState>(
      builder: (context, state) {
        if (state is TrackInitial) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: state.tracks.length,
            itemBuilder: (context, index) {
              final track = state.tracks[index];

              return ListTile(
                onTap: () => audioBloc.add(AudioPlay(state.tracks, index)),
                leading: Container(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.music_note),
                ),
                title: Text(
                  track.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  track.artist?.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  style: Theme.of(context).iconButtonTheme.style,
                  onPressed: () => trackBloc.add(TrackToggleFavorite(track)),
                  icon: Icon(
                    track.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
