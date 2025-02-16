import 'package:flutter/material.dart';
import '../albums/albums_view.dart';
import '../artists/artists_view.dart';
import '../playlists/playlists_view.dart';
import '../tracks/tracks_tab.dart';
import '../../widgets/atoms/spacer.dart';
import '../../../../core/l10n/retip_l10n.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView>
    with SingleTickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    final tabs = [
      l10n.playlists,
      l10n.artists,
      l10n.albums,
      l10n.tracks,
    ];

    final currentTab = tabs[controller.index];

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              leading: const Icon(Icons.library_music),
              title: Text(currentTab),
              pinned: true,
              floating: true,
              snap: true,
              actions: const [
                IconButton(icon: Icon(Icons.sort), onPressed: null),
                HorizontalSpacer(),
                IconButton(icon: Icon(Icons.grid_view), onPressed: null),
                HorizontalSpacer(),
                IconButton(icon: Icon(Icons.more_vert), onPressed: null),
                HorizontalSpacer(),
              ],
              bottom: TabBar(
                controller: controller,
                indicatorSize: TabBarIndicatorSize.tab,
                tabAlignment: TabAlignment.fill,
                tabs: const [
                  Tab(icon: Icon(Icons.playlist_play)),
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.album)),
                  Tab(icon: Icon(Icons.music_note)),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: controller,
          children: const [
            PlaylistsView(),
            ArtistsView(),
            AlbumsView(),
            TracksTab(),
          ],
        ),
      ),
    );
  }
}
