import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/blocs/albums/albums_bloc.dart';
import 'package:retip/app/presentation/widgets/albums_list_view.dart';

import '../../blocs/tracks/tracks_bloc.dart';
import '../../widgets/tracks_list_view.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.library_music),
          title: Text('Library'),
          bottom: TabBar(
            tabAlignment: TabAlignment.center,
            indicatorSize: TabBarIndicatorSize.tab,
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
            Center(child: Text('Playlists content goes here')),
            Center(child: Text('Genres content goes here')),
            Center(child: Text('Artists content goes here')),
            AlbumsListView(albumsBloc: context.read<AlbumsBloc>()),
            TracksListView(tracksBloc: context.read<TracksBloc>()),
          ],
        ),
      ),
    );
  }
}
