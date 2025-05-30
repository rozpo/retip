import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:retip/app/data/providers/file_provider.dart';
import 'package:retip/app/domain/entities/track_entity.dart';

class JustAudioProvider extends AudioPlayer {
  final tracks = <TrackEntity>[];

  TrackEntity? get nextArtist {
    return nextIndex != null ? tracks[nextIndex!] : null;
  }

  TrackEntity? get previousArtist {
    return previousIndex != null ? tracks[previousIndex!] : null;
  }

  Future<void> next() async => await seekToNext();

  Future<void> previous() async => await seekToPrevious();

  Future<void> seekToIndex(int index) async {
    await seek(
      Duration.zero,
      index: index,
    );
  }

  Future<void> setPlaylist(List<TrackEntity> tracks, [int? index]) async {
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

    await setAudioSource(
      ConcatenatingAudioSource(children: children),
      initialIndex: index,
    );
  }
}
