import 'package:flutter/material.dart';

import '../views/albums_view.dart';
import '../views/artists_view.dart';
import '../views/genres_view.dart';
import '../views/tracks_view.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          children: const [
            TracksView(),
            AlbumsView(),
            ArtistsView(),
            GenresView(),
          ],
        ),
      ),
    );
  }
}
