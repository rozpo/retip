import 'package:flutter/material.dart';
import 'package:retip/app/views/home/pages/library/tabs/playlists/playlists_tab.dart';
import 'package:retip/app/widgets/rp_app_bar.dart';

import 'package:retip/core/l10n/retip_l10n.dart';

import 'tabs/albums/albums_tab.dart';
import 'tabs/artists/artists_tab.dart';
import 'tabs/tracks/tracks_tab.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: RpAppBar(
          leading: const Icon(Icons.library_music),
          title: Text(RetipL10n.of(context).library),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                text: RetipL10n.of(context).playlists,
                icon: const Icon(Icons.queue_music),
              ),
              Tab(
                text: RetipL10n.of(context).artists,
                icon: const Icon(Icons.person),
              ),
              Tab(
                text: RetipL10n.of(context).albums,
                icon: const Icon(Icons.album),
              ),
              Tab(
                text: RetipL10n.of(context).tracks,
                icon: const Icon(Icons.queue_music),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            PlaylistsTab(),
            ArtistsTab(),
            AlbumsTab(),
            TracksTab(),
          ],
        ),
      ),
    );
  }
}
