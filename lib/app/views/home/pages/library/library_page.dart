import 'package:flutter/material.dart';

import 'package:retip/core/l10n/retip_l10n.dart';

import 'tabs/albums/albums_tab.dart';
import 'tabs/artists/artists_tab.dart';
import 'tabs/tracks/tracks_tab.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  final tabs = const [
    ArtistsTab(),
    AlbumsTab(),
    TracksTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(RetipL10n.of(context).library),
          bottom: TabBar(tabs: [
            Tab(text: RetipL10n.of(context).artists),
            Tab(text: RetipL10n.of(context).albums),
            Tab(text: RetipL10n.of(context).tracks),
          ]),
        ),
        body: TabBarView(
          children: tabs,
        ),
      ),
    );
  }
}
