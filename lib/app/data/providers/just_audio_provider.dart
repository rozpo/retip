import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:retip/app/domain/entities/track_entity.dart';

import 'file_provider.dart';

class JustAudioProvider extends AudioPlayer {
  final playlist = ConcatenatingAudioSource(children: []);
  final tracks = <TrackEntity>[];

  Future<void> setPlaylist(List<TrackEntity> tracks, [int index = 0]) async {
    final fileProvider = FileProvider();

    final children = <AudioSource>[];

    for (final track in tracks) {
      String artworkUrl = '';

      if (track.artwork != null) {
        final path = await fileProvider.getFilePath('track_${track.id}');

        if (path == null) {
          final file =
              await fileProvider.writeFile(track.artwork!, 'track_${track.id}');
          artworkUrl = file.path;
        } else {
          artworkUrl = path;
        }
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
