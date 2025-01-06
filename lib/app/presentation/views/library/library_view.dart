import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/presentation/views/albums/albums_view.dart';
import 'package:retip/app/presentation/views/artists/artists_view.dart';
import 'package:retip/app/presentation/views/playlists/playlists_view.dart';
import 'package:retip/app/presentation/views/tracks/tracks_view.dart';
import 'package:retip/app/presentation/widgets/rp_app_bar.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

import 'bloc/library_bloc.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
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
                PlaylistsView(),
                ArtistsView(),
                AlbumsView(),
                TracksView(),
              ],
            ),
          ),
        );
      },
    );
  }
}
