import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retip/app/views/dev/dev_menu.dart';
import 'package:retip/app/widgets/rp_icon_button.dart';

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
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool isSearching = false;

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.library_music),
          title: isSearching
              ? SearchBar(
                  focusNode: focusNode,
                  autoFocus: false,
                  onChanged: (value) {
                    setState(() {});
                  },
                  hintText: '${RetipL10n.of(context).search}...',
                  controller: controller,
                  leading: const Icon(Icons.search),
                  trailing: [
                    IconButton(
                      onPressed: () {
                        isSearching = false;
                        controller.text = '';
                        focusNode.unfocus();
                        setState(() {});
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                )
              : Text(RetipL10n.of(context).library),
          actions: [
            if (kReleaseMode == false) ...[
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DevMenu(),
                  ),
                ),
                icon: const Icon(Icons.developer_board),
              ),
            ],
            const RpIconButton(icon: Icons.sort),
            const RpIconButton(icon: Icons.grid_view),
            const RpIconButton(icon: Icons.settings),
          ],
          bottom: TabBar(tabs: [
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
          ]),
        ),
        body: TabBarView(
          children: [
            ArtistsTab(search: controller.text),
            AlbumsTab(search: controller.text),
            const TracksTab(),
          ],
        ),
      ),
    );
  }
}
