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
      String? artworkUrl;

      if (track.artwork != null && track.albumId != null) {
        artworkUrl = await fileProvider.getFilePath('album_${track.albumId}');
      }

      final mediaItem = MediaItem(
        id: track.hashCode.toString(),
        title: track.title,
        album: track.album,
        artist: track.artist,
        artUri: artworkUrl != null ? Uri.parse('file://$artworkUrl') : null,
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
