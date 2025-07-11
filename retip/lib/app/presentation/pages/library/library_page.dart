import 'package:flutter/material.dart';

import 'widgets/albums_view.dart';
import 'widgets/artists_view.dart';
import 'widgets/genres_view.dart';
import 'widgets/playlists_view.dart';
import 'widgets/tracks_view.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: _index,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.library_music),
          title: Text('Library'),
          bottom: TabBar(
            onFocusChange: (value, index) {
              setState(() {
                _index = index;
              });
            },
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
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
            PlaylistsView(),
            GenresView(),
            ArtistsView(),
            AlbumsView(),
            TracksView(),
          ],
        ),
      ),
    );
  }
}
