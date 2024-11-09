import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retip/app/views/dev/dev_menu.dart';
import 'package:retip/app/widgets/rp_app_bar.dart';
import 'package:retip/app/widgets/rp_icon_button.dart';
import 'package:retip/app/widgets/spacer.dart';

import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

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
      length: 3,
      child: Scaffold(
        appBar: RpAppBar(
          leading: const Icon(Icons.library_music),
          title: Text(RetipL10n.of(context).library),
          actions: [
            if (kReleaseMode == false) ...[
              const HorizontalSpacer(),
              RpIconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DevMenu(),
                  ),
                ),
                icon: Icons.developer_board,
              ),
            ],
            const HorizontalSpacer()
          ],
          bottom: TabBar(
            labelPadding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
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
          children: [
            ArtistsTab(),
            AlbumsTab(),
            TracksTab(),
          ],
        ),
      ),
    );
  }
}
