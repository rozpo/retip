import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/tracks/tracks_view.dart';
import 'package:retip/app/views/home/pages/library/tabs/albums/albums_tab.dart';
import 'package:retip/app/views/home/pages/library/tabs/artists/artists_tab.dart';
import 'package:retip/app/views/home/pages/library/tabs/playlists/playlists_tab.dart';
import 'package:retip/app/widgets/rp_app_bar.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

import 'bloc/library_bloc.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    final tabs = [
      Tab(
        text: l10n.playlists,
        icon: const Icon(Icons.queue_music),
      ),
      Tab(
        text: l10n.artists,
        icon: const Icon(Icons.person),
      ),
      Tab(
        text: l10n.albums,
        icon: const Icon(Icons.album),
      ),
      Tab(
        text: l10n.tracks,
        icon: const Icon(Icons.queue_music),
      ),
    ];

    return BlocConsumer<LibraryBloc, LibraryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return DefaultTabController(
          length: tabs.length,
          child: Scaffold(
            appBar: RpAppBar(
              leading: const Icon(Icons.library_music),
              title: Text(l10n.library),
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: tabs,
              ),
            ),
            body: const TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                PlaylistsTab(),
                ArtistsTab(),
                AlbumsTab(),
                TracksView(),
              ],
            ),
          ),
        );
      },
    );
  }
}
