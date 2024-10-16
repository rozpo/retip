import 'dart:io';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:retip/app/services/entities/track_entity.dart';

class RetipAudio extends AudioPlayer {
  ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(
    children: [],
  );

  List<TrackEntity> tracks = [];

  ConcatenatingAudioSource get playlist => _playlist;

  Future<void> next() async => await seekToNext();

  Future<void> previous() async => await seekToPrevious();

  Future<void> seekToIndex(int index) async {
    await seek(
      Duration.zero,
      index: index,
    );
  }

  Future<Duration?> playlistAddAll(List<TrackEntity> tracks) async {
    final tmpDir = await getTemporaryDirectory();
    final children = <AudioSource>[];

    for (final track in tracks) {
      String artworkUrl = '';

      if (track.artwork != null) {
        final file = File('${tmpDir.path}/${track.hashCode}.png');
        await file.writeAsBytes(track.artwork!);
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

    this.tracks = tracks;

    _playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: children,
    );

    return await setAudioSource(_playlist);
  }

  Future<void> playlistClear() async {
    await _playlist.clear();
    tracks.clear();
  }

  Future<void> setShuffleMode(bool enabled) async {
    await setShuffleModeEnabled(enabled);
  }

  bool get showMiniplayer {
    return playerState.processingState == ProcessingState.ready;
  }
}
