import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/audio/audio_bloc.dart';
import '../../../blocs/library/library_bloc.dart';
import '../../../widgets/list_tiles/track_list_tile_widget.dart';

class LibraryTracksTabWidget extends StatelessWidget {
  const LibraryTracksTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        if (state is LibraryLoadedState) {
          final tracks = state.tracks;

          return ListView.builder(
            itemCount: tracks.length,
            itemBuilder: (context, index) {
              final track = tracks[index];

              return TrackListTileWidget(
                track: track,
                onTap: () {
                  final event = AudioLoadPlaylistEvent(
                    tracks,
                    index: index,
                  );
                  context.read<AudioBloc>().add(event);
                },
              );
            },
          );
        } else {
          return Center(
            child: FilledButton(
              onPressed: () {
                context.read<LibraryBloc>().add(const LibraryScanEvent());
              },
              child: const Text('Scan Library'),
            ),
          );
        }
      },
    );
  }
}
