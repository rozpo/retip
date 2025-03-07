import 'package:just_audio/just_audio.dart';

import '../../domain/entities/track_entity.dart';

class JustAudioProvider {
  final AudioPlayer _audioPlayer;

  JustAudioProvider._(
    AudioPlayer audioPlayer,
  ) : _audioPlayer = audioPlayer;

  static Future<JustAudioProvider> init() async {
    return JustAudioProvider._(AudioPlayer());
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> play(List<TrackEntity> tracks, int index) async {
    final playlist = ConcatenatingAudioSource(
      children: tracks.map((track) {
        return AudioSource.uri(Uri.parse(track.location));
      }).toList(),
    );

    await _audioPlayer.setAudioSource(playlist, initialIndex: index);
    await _audioPlayer.play();
  }

  Future<void> resume() async {
    await _audioPlayer.play();
  }

  Future<void> next() async {
    await _audioPlayer.seekToNext();
  }

  Future<void> previous() async {
    await _audioPlayer.seekToPrevious();
  }

  Stream<Duration> get duration {
    return _audioPlayer.durationStream.map((event) => event ?? Duration.zero);
  }

  Stream<int> get index {
    return _audioPlayer.currentIndexStream.map((event) => event ?? 0);
  }

  Stream<bool> get isPlaying => _audioPlayer.playingStream;

  Stream<Duration> get position => _audioPlayer.positionStream;
}
