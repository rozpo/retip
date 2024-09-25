import 'package:flutter/material.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/views/home/pages/album/album_page.dart';

class ArtistPage extends StatelessWidget {
  final ArtistEntity artist;

  const ArtistPage({
    required this.artist,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artist.name),
      ),
      body: ListView(
        children: artist.albums
            .map(
              (album) => ListTile(
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
              ),
            )
            .toList(),
      ),
    );
  }
}
