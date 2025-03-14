import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/album_repository.dart';
import '../../domain/repositories/track_repository.dart';
import '../blocs/audio/audio_bloc.dart';
import '../widgets/atoms/divider_widget.dart';
import '../widgets/organisms/tracks_list_widget.dart';

class AlbumPage extends StatelessWidget {
  final int albumId;

  const AlbumPage(this.albumId, {super.key});

  @override
  Widget build(BuildContext context) {
    final albumRepository = context.read<AlbumRepository>();
    final audioBloc = context.read<AudioBloc>();

    return StreamBuilder(
      stream: albumRepository.albumStream(albumId),
      builder: (context, snapshot) {
        if (snapshot.hasData == false || snapshot.requireData == null) {
          return const SizedBox();
        }

        final album = snapshot.requireData!;

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Text(album.title),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: DividerWidget(),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  album.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () => albumRepository.toggleFavorite(album),
              ),
            ],
          ),
          body: StreamBuilder(
            stream: context.read<TrackRepository>().streamByAlbum(albumId),
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
