import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/services/album_service.dart';
import '../blocs/album/album_bloc.dart';
import '../blocs/audio/audio_bloc.dart';
import '../widgets/list_tiles/track_list_tile_widget.dart';
import '../widgets/modal_bottom_sheets/album_modal_bottom_sheet_widget.dart';

class AlbumPage extends StatelessWidget {
  final int id;

  const AlbumPage({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumState>(
      bloc: AlbumBloc(
        albumService: context.read<AlbumService>(),
        albumId: id,
      ),
      builder: (context, state) {
        if (state is AlbumLoadedState) {
          final tracks = state.tracks;

          return Scaffold(
            appBar: AppBar(
              title: Text(state.album.title),
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    AlbumModalBottomSheetWidget(state.album).show(context);
                  },
                )
              ],
            ),
            body: ListView.builder(
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
            ),
          );
        }

        return Scaffold(appBar: AppBar());
      },
    );
  }
}
