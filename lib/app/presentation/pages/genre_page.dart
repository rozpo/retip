import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/genre_repository.dart';
import '../../domain/repositories/track_repository.dart';
import '../blocs/audio/audio_bloc.dart';
import '../widgets/atoms/divider_widget.dart';
import '../widgets/organisms/sheets/track_sheet_widget.dart';
import '../widgets/organisms/tracks_list_widget.dart';

class GenrePage extends StatelessWidget {
  final int genreId;

  const GenrePage(this.genreId, {super.key});

  @override
  Widget build(BuildContext context) {
    final genreRepository = context.read<GenreRepository>();
    final audioBloc = context.read<AudioBloc>();

    return StreamBuilder(
      stream: genreRepository.genreStream(genreId),
      builder: (context, snapshot) {
        if (snapshot.hasData == false || snapshot.requireData == null) {
          return const SizedBox();
        }

        final genre = snapshot.requireData!;

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Text(genre.name),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: DividerWidget(),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  genre.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () => genreRepository.toggleFavorite(genre),
              ),
            ],
          ),
          body: StreamBuilder(
            stream: context.read<TrackRepository>().streamByGenre(genreId),
            builder: (context, snapshot) {
              if (snapshot.hasData == false) return const SizedBox();

              final tracks = snapshot.requireData;
              return TracksListWidget(
                tracks: tracks,
                onTap: (index) => audioBloc.add(AudioPlay(tracks, index)),
                onActionTap: (index) =>
                    TrackSheetWidget(tracks[index]).show(context),
              );
            },
          ),
        );
      },
    );
  }
}
