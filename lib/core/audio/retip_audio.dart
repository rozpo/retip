import 'package:just_audio/just_audio.dart';

class RetipAudio {
  final _audioPlayer = AudioPlayer();

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

  Future<Duration?> playlistAddAll(List<Uri> urls) async {
    final children = urls.map((e) => AudioSource.uri(e)).toList();

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
