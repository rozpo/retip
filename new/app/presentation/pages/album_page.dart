import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/services/album_service.dart';
import '../blocs/album/album_bloc.dart';
import '../widgets/list_tiles/track_list_tile_widget.dart';

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
              title: Text('Album $id'),
            ),
            body: ListView.builder(
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                final track = tracks[index];

                return TrackListTileWidget(track: track);
              },
            ),
          );
        }

        return Scaffold(appBar: AppBar());
      },
    );
  }
}
