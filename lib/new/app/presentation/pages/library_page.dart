import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';

import '../../data/models/track_model.dart';
import '../views/tracks/tracks_view.dart';

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
                store.box<TrackModel>().removeAllAsync();
              },
            ),
          ],
        ),
        body: PageView(
          children: const [
            TracksView(),
          ],
        ),
      ),
    );
  }
}
