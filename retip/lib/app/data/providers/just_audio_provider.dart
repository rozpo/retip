import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';

final class JustAudioProvider {
  final AudioPlayer _audioPlayer;

  const JustAudioProvider._(this._audioPlayer);

  static Future<JustAudioProvider> init() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'dev.rozpo.retip.audio',
      // androidNotificationIcon: 'drawable/ic_stat_name',
      androidNotificationOngoing: true,
    );

    return JustAudioProvider._(AudioPlayer());
  }

  List<AudioSource> _mapToAudioSource(List<TrackEntity> tracks) {
    final sources = tracks.map(
      (e) => AudioSource.uri(
        e.location,
        tag: MediaItem(
          id: e.trackId.toString(),
          title: e.title,
          artist: e.artist,
        ),
      ),
    );

    return sources.toList();
  }

  Future<void> setAudioSources(List<TrackEntity> tracks, {int? index}) async {
    final sources = _mapToAudioSource(tracks);

    await _audioPlayer.setAudioSources(sources, initialIndex: index);
  }

  Future<void> addAudioSources(List<TrackEntity> tracks) async {
    final sources = _mapToAudioSource(tracks);
    await _audioPlayer.addAudioSources(sources);
  }

  void play() => _audioPlayer.play();

  void pause() => _audioPlayer.pause();

  Stream<int?> get currentIndexStream => _audioPlayer.currentIndexStream;

  Stream<Duration> get positionStream => _audioPlayer.positionStream;

  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
}
