import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/get_all_albums.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/views/home/pages/album/album_page.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/utils.dart';

class AlbumsTab extends StatelessWidget {
  final String search;
  const AlbumsTab({this.search = '', super.key});

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

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final album = data[index];

              return ListTile(
                leading:
                    album.artwork != null ? Image.memory(album.artwork!) : null,
                title: RetipUtils.getQueryText(context, album.title, search),
                subtitle: Text(album.artist),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AlbumPage(album: album);
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
