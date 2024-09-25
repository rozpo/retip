import 'package:flutter/material.dart';
import 'package:retip/app/services/entities/album_entity.dart';

class AlbumPage extends StatelessWidget {
  final AlbumEntity album;

  const AlbumPage({
    required this.album,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
      ),
      body: ListView(
        children: album.tracks
            .map(
              (track) => ListTile(
                title: Text(track.title),
                subtitle: Text(track.artist),
              ),
            )
            .toList(),
      ),
    );
  }
}
