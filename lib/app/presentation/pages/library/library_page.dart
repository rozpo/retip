import 'package:flutter/material.dart';

import '../../views/albums_view.dart';
import '../../views/artists_view.dart';
import '../../views/genres_view.dart';
import '../../views/playlists_view.dart';
import '../../views/tracks_view.dart';
import '../../widgets/sheets/sort_sheet_widget.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.sort),
              onPressed: () {
                const SortSheetWidget().show(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.grid_view),
              onPressed: () {},
            ),
          ],
          leading: const Icon(Icons.library_music),
          title: const Text('Library'),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(text: 'Playlists'),
              Tab(text: 'Artists'),
              Tab(text: 'Albums'),
              Tab(text: 'Genres'),
              Tab(text: 'Tracks'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PlaylistsView(),
            ArtistsView(),
            AlbumsView(),
            GenresView(),
            TracksView(),
          ],
        ),
      ),
    );
  }
}
