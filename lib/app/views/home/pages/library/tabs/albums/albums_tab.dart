import 'package:flutter/material.dart';
import 'package:retip/app/data/repositories/on_audio_query_album_repository.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/views/home/pages/album/album_page.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class AlbumsTab extends StatelessWidget {
  const AlbumsTab({super.key});

  static Future<List<AlbumEntity>> future =
      OnAudioQueryAlbumRepository().getAll();

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

          final data = snapshot.requireData;

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
                title: Text(album.title),
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
