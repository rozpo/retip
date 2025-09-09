import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/domain/enitities/album_entity.dart';
import 'package:retip/app/domain/enitities/artist_entity.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/domain/repositories/album_repository.dart';
import 'package:retip/app/domain/repositories/track_repository.dart';
import 'package:retip/app/presentation/blocs/album/album_bloc.dart';
import 'package:retip/app/presentation/blocs/artist/artist_bloc.dart';
import 'package:retip/app/presentation/blocs/track/track_bloc.dart';
import 'package:retip/app/presentation/widgets/buttons/icon/settings_icon_button_widget.dart';
import 'package:retip/core/router/retip_route.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: SettingsIconButtonWidget(),
          title: Text('Library'),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
          bottom: TabBar(
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 8),
                    Text('Artists'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.album),
                    SizedBox(width: 8),
                    Text('Albums'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.music_note),
                    SizedBox(width: 8),
                    Text('Tracks'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocBuilder<ArtistBloc, ArtistState>(
              builder: (context, state) {
                final artists = <ArtistEntity>[];

                if (state is ArtistIdleState) {
                  artists.addAll(state.artists);
                }

                return ListView.builder(
                  itemCount: artists.length,
                  itemBuilder: (context, index) {
                    final artist = artists[index];

                    return ListTile(
                      leading: Icon(Icons.person),
                      title: Text(artist.name),
                      onTap: () => RetipRoute.artist.push(
                        pathParameters: {'id': artist.artistId.toString()},
                        context,
                      ),
                    );
                  },
                );
              },
            ),
            BlocBuilder<AlbumBloc, AlbumState>(
              bloc: AlbumBloc(context.read<AlbumRepository>())
                ..add(AlbumFetchAllEvent()),
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
            BlocBuilder<TrackBloc, TrackState>(
              bloc: TrackBloc(context.read<TrackRepository>())
                ..add(TrackFetchAllEvent()),
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
          ],
        ),
      ),
    );
  }
}
