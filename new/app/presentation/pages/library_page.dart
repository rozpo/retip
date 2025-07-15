import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_routes.dart';
import '../blocs/audio/audio_bloc.dart';
import '../blocs/library/library_bloc.dart';
import '../widgets/icon_buttons/profile_icon_button_widget.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Library'),
          actions: const [
            ProfileIconButtonWidget(),
          ],
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            tabs: [
              Tab(text: 'Playlists'),
              Tab(text: 'Genres'),
              Tab(text: 'Artists'),
              Tab(text: 'Albums'),
              Tab(text: 'Tracks'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Playlist $index'),
                  onTap: () => context.pushNamed(
                    RetipRoutes.playlist,
                    pathParameters: {
                      'id': index.toString(),
                    },
                  ),
                );
              },
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Genre $index'),
                  onTap: () => context.pushNamed(
                    RetipRoutes.genre,
                    pathParameters: {
                      'id': index.toString(),
                    },
                  ),
                );
              },
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Artist $index'),
                  onTap: () => context.pushNamed(
                    RetipRoutes.artist,
                    pathParameters: {
                      'id': index.toString(),
                    },
                  ),
                );
              },
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Album $index'),
                  onTap: () => context.pushNamed(
                    RetipRoutes.album,
                    pathParameters: {
                      'id': index.toString(),
                    },
                  ),
                );
              },
            ),
            BlocBuilder<LibraryBloc, LibraryState>(
              builder: (context, state) {
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
              },
            )
          ],
        ),
      ),
    );
  }
}
