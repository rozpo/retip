import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/playlist_repository.dart';
import '../../domain/repositories/track_repository.dart';
import '../blocs/audio/audio_bloc.dart';
import '../widgets/atoms/divider_widget.dart';
import '../widgets/organisms/tracks_list_widget.dart';

class PlaylistPage extends StatelessWidget {
  final int playlistId;

  const PlaylistPage(
    this.playlistId, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final playlistRepository = context.read<PlaylistRepository>();
    final audioBloc = context.read<AudioBloc>();

    return StreamBuilder(
      stream: playlistRepository.read(playlistId),
      builder: (context, snapshot) {
        if (snapshot.hasData == false || snapshot.requireData == null) {
          return const SizedBox();
        }

        final playlist = snapshot.requireData!;

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Text(playlist.name),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: DividerWidget(),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  playlist.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () => playlistRepository.toggleFavorite(playlist),
              ),
            ],
          ),
          body: StreamBuilder(
            stream: context.read<TrackRepository>().streamByIds(
                  playlist.tracks.map((e) => e.id).toList(),
                ),
            builder: (context, snapshot) {
              if (snapshot.hasData == false) return const SizedBox();

              final tracks = snapshot.requireData;
              return TracksListWidget(
                tracks: tracks,
                onTap: (index) => audioBloc.add(AudioPlay(tracks, index)),
              );
            },
          ),
        );
      },
    );
  }
}
