import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/views/player/player_view.dart';
import 'package:retip/core/audio/retip_audio.dart';

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
      body: ListView.builder(
        itemCount: album.tracks.length,
        itemBuilder: (context, index) {
          final track = album.tracks[index];

          return ListTile(
            title: Text(track.title),
            subtitle: Text(track.artist),
            onTap: () async {
              final audio = GetIt.instance.get<RetipAudio>();

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlayerView(
                    player: audio,
                  ),
                ),
              );

              await audio.playlistAddAll(album.tracks);
              await audio.stop();
              await audio.seekToIndex(index);
              await audio.play();
            },
          );
        },
      ),
    );
  }
}
