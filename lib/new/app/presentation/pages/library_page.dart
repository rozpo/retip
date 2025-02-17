import 'package:flutter/material.dart';

import '../views/albums_view.dart';
import '../views/artists_view.dart';
import '../views/tracks_view.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Retip'),
        ),
        body: PageView(
          children: const [
            ArtistsView(),
            AlbumsView(),
            TracksView(),
          ],
        ),
      ),
    );
  }
}
