import 'package:flutter/material.dart';

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

  bool isSearching = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: isSearching
              ? SearchBar(
                  autoFocus: true,
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
                        setState(() {});
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                )
              : Text(RetipL10n.of(context).library),
          actions: isSearching
              ? null
              : [
                  IconButton(
                    onPressed: () {
                      isSearching = true;
                      setState(() {});
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
          bottom: TabBar(tabs: [
            Tab(text: RetipL10n.of(context).artists),
            Tab(text: RetipL10n.of(context).albums),
            Tab(text: RetipL10n.of(context).tracks),
          ]),
        ),
        body: TabBarView(
          children: [
            ArtistsTab(search: controller.text),
            AlbumsTab(search: controller.text),
            TracksTab(search: controller.text),
          ],
        ),
      ),
    );
  }
}
