import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:retip/app/services/entities/track_entity.dart';

class RetipAudio {
  final _audioPlayer = AudioPlayer();

  AudioPlayer get player => _audioPlayer;

  ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(
    children: [],
  );

  Future<void> play() async => await _audioPlayer.play();

  Future<void> pause() async => await _audioPlayer.pause();

  Future<void> stop() async => await _audioPlayer.stop();

  Future<void> next() async => await _audioPlayer.seekToNext();

  Future<void> previous() async => await _audioPlayer.seekToPrevious();

  Future<void> seekToIndex(int index) async {
    await _audioPlayer.seek(
      Duration.zero,
      index: index,
    );
  }

  Future<Duration?> playlistAddAll(List<TrackEntity> tracks) async {
    final children = <AudioSource>[];

    for (final track in tracks) {
      final mediaItem = MediaItem(
        id: track.hashCode.toString(),
        title: track.title,
        album: track.album,
        artist: track.artist,
      );

      children.add(AudioSource.uri(track.uri, tag: mediaItem));
    }

    _playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: children,
    );

    return await _audioPlayer.setAudioSource(_playlist);
  }

  Future<void> playlistClear() async {
    await _playlist.clear();
  }

  Future<void> setShuffleMode(bool enabled) async {
    await _audioPlayer.setShuffleModeEnabled(enabled);
  }
}
