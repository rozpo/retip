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

  Future<void> load(List<TrackEntity> tracks, {int? index}) async {
    final sources = tracks
        .map(
          (e) => AudioSource.uri(
            e.location,
            tag: MediaItem(
              id: e.trackId.toString(),
              title: e.title,
              artist: e.artist,
            ),
          ),
        )
        .toList();

    await _audioPlayer.setAudioSources(sources, initialIndex: index);
  }

  void play() => _audioPlayer.play();

  void pause() => _audioPlayer.pause();
}
