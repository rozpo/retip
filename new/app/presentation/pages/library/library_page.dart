import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_routes.dart';
import '../../widgets/icon_buttons/profile_icon_button_widget.dart';
import 'widgets/library_albums_tab_widget.dart';
import 'widgets/library_artists_tab_widget.dart';
import 'widgets/library_tracks_tab_widget.dart';

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
            const LibraryArtistsTabWidget(),
            const LibraryAlbumsTabWidget(),
            const LibraryTracksTabWidget(),
          ],
        ),
      ),
    );
  }
}
