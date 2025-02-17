import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';

import '../../domain/entities/album.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/track.dart';
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
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () {
                final store = GetIt.I.get<Store>();
                store.box<Track>().removeAllAsync();
                store.box<Album>().removeAllAsync();
                store.box<Artist>().removeAllAsync();
              },
            ),
          ],
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
