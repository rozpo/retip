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
          actions: isSearching
              ? null
              : [
                  IconButton(
                    onPressed: () {
                      isSearching = true;
                      focusNode.requestFocus();
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
