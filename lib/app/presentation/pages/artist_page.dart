import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/artist_repository.dart';
import '../../domain/repositories/track_repository.dart';
import '../blocs/audio/audio_bloc.dart';
import '../widgets/atoms/divider_widget.dart';
import '../widgets/organisms/tracks_list_widget.dart';

class ArtistPage extends StatelessWidget {
  final int artistId;

  const ArtistPage(this.artistId, {super.key});

  @override
  Widget build(BuildContext context) {
    final albumRepository = context.read<ArtistRepository>();
    final audioBloc = context.read<AudioBloc>();

    return StreamBuilder(
      stream: albumRepository.artistStream(artistId),
      builder: (context, snapshot) {
        if (snapshot.hasData == false || snapshot.requireData == null) {
          return const SizedBox();
        }

        final artist = snapshot.requireData!;

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Text(artist.name),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: DividerWidget(),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  artist.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () => albumRepository.toggleFavorite(artist),
              ),
            ],
          ),
          body: StreamBuilder(
            stream: context.read<TrackRepository>().streamByArtist(artistId),
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
