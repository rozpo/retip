import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/get_all_albums.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/views/playlist/playlist_view.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

class PlaylistsTab extends StatelessWidget {
  final String search;

  const PlaylistsTab({this.search = '', super.key});

  static Future<List<AlbumEntity>> future = GetAllAlbums.call();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final data = snapshot.requireData
              .where(
                  (e) => e.title.toLowerCase().contains(search.toLowerCase()))
              .toList();

          if (data.isEmpty) {
            return Center(
              child: Text(RetipL10n.of(context).noAlbums),
            );
          }

          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
                vertical: Sizer.x1 + Sizer.x0_5, horizontal: Sizer.x0_5),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final album = data[index];

              return Padding(
                padding: const EdgeInsets.all(Sizer.x0_5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return PlaylistView(album: album);
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: album.artwork == null
                          ? Theme.of(context).colorScheme.surfaceContainer
                          : null,
                      borderRadius: BorderRadius.circular(Sizer.x1),
                      border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.surfaceBright),
                      image: album.artwork != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.memory(album.artwork!).image,
                            )
                          : null,
                    ),
                    child: album.artwork == null
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(Sizer.x1),
                              child: Text(
                                album.title,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
