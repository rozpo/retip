import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/track_repository.dart';
import '../blocs/audio/audio_bloc.dart';
import '../widgets/organisms/play_shuffle_buttons_widget.dart';
import '../widgets/organisms/tracks_list_widget.dart';

class GenrePage extends StatelessWidget {
  final int genreId;

  const GenrePage(this.genreId, {super.key});

  @override
  Widget build(BuildContext context) {
    final trackRepository = context.read<TrackRepository>();
    final audioBloc = context.read<AudioBloc>();

    return StreamBuilder(
      stream: trackRepository.streamByGenre(genreId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final tracks = snapshot.requireData;

        return Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Column(
                children: [
                  ShufflePlayButtonsWidget(
                    onPlayTap: () => audioBloc.add(
                      AudioPlay(tracks, 0),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          body: TracksListWidget(
            onTap: (index) => audioBloc.add(AudioPlay(tracks, index)),
            tracks: tracks,
          ),
        );
      },
    );
  }
}
