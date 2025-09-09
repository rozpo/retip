import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/domain/enitities/album_entity.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/domain/repositories/album_repository.dart';
import 'package:retip/app/domain/repositories/track_repository.dart';
import 'package:retip/app/presentation/blocs/album/album_bloc.dart';
import 'package:retip/app/presentation/blocs/track/track_bloc.dart';
import 'package:retip/core/router/retip_route.dart';

class ArtistPage extends StatelessWidget {
  final int id;

  const ArtistPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Artist $id')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<AlbumBloc, AlbumState>(
              bloc: AlbumBloc(context.read<AlbumRepository>())
                ..add(AlbumFetchByArtistEvent(id)),
              builder: (context, state) {
                final albums = <AlbumEntity>[];

                if (state is AlbumIdleState) {
                  albums.addAll(state.albums);
                }

                return ListView.builder(
                  itemCount: albums.length,
                  itemBuilder: (context, index) {
                    final album = albums[index];

                    return ListTile(
                      leading: Icon(Icons.album),
                      title: Text(album.title),
                      subtitle: Text(album.artist),
                      onTap: () => RetipRoute.album.push(
                        pathParameters: {'id': album.albumId.toString()},
                        context,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Divider(),
          Expanded(
            child: BlocBuilder<TrackBloc, TrackState>(
              bloc: TrackBloc(context.read<TrackRepository>())
                ..add(TrackFetchByArtistEvent(id)),
              builder: (context, state) {
                final tracks = <TrackEntity>[];

                if (state is TrackIdleState) {
                  tracks.addAll(state.tracks);
                }

                return ListView.builder(
                  itemCount: tracks.length,
                  itemBuilder: (context, index) {
                    final track = tracks[index];

                    return ListTile(
                      leading: Icon(Icons.music_note),
                      title: Text(track.title),
                      subtitle: Text(track.artist),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
