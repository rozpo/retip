import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/retip_routes.dart';
import '../../../blocs/audio/audio_bloc.dart';
import '../../../blocs/library/library_bloc.dart';

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

              return ListTile(
                title: Text(track.title),
                subtitle: Text(track.artist),
                onTap: () {
                  final event = AudioLoadPlaylistEvent(
                    tracks,
                    index: index,
                  );
                  context.read<AudioBloc>().add(event);
                },
                onLongPress: () => context.pushNamed(
                  RetipRoutes.track,
                  pathParameters: {
                    'id': track.trackId.toString(),
                  },
                ),
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
