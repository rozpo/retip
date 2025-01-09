import 'dart:io';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:retip/app/domain/entities/track_entity.dart';

class JustAudioProvider extends AudioPlayer {
  final playlist = ConcatenatingAudioSource(children: []);
  final tracks = <TrackEntity>[];

  Future<void> setPlaylist(List<TrackEntity> tracks, [int index = 0]) async {
    final tmpDir = await getTemporaryDirectory();
    final children = <AudioSource>[];

    for (final track in tracks) {
      String artworkUrl = '';

      if (track.artwork != null) {
        final file = File('${tmpDir.path}/${track.hashCode}.png');

        if (await file.exists() == false) {
          await file.writeAsBytes(track.artwork!);
        }

        artworkUrl = file.path;
      }

      final mediaItem = MediaItem(
        id: track.hashCode.toString(),
        title: track.title,
        album: track.album,
        artist: track.artist,
        artUri: artworkUrl.isNotEmpty ? Uri.parse('file://$artworkUrl') : null,
      );

      children.add(AudioSource.uri(track.uri, tag: mediaItem));
    }

    this.tracks.clear();
    this.tracks.addAll(tracks);

    playlist.clear();
    playlist.addAll(children);

    await setAudioSource(playlist, initialIndex: index);
  }
}
