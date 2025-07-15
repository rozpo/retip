import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../../domain/entites/track_entity.dart';

class JustAudioProvider {
  final AudioPlayer _audioPlayer;

  const JustAudioProvider._(this._audioPlayer);

  static Future<JustAudioProvider> init() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'dev.rozpo.retip.audio',
      androidNotificationIcon: 'drawable/ic_stat_name',
    );

    final player = AudioPlayer();

    return JustAudioProvider._(player);
  }

  Future<void> loadPlaylist(List<TrackEntity> tracks, [int? index]) async {
    final audioSources = tracks.map(
      (e) {
        return AudioSource.uri(
          Uri.parse(e.location),
          tag: MediaItem(
            id: e.trackId.toString(),
            title: e.title,
          ),
        );
      },
    ).toList();

    await _audioPlayer.setAudioSource(
      ConcatenatingAudioSource(children: audioSources),
      initialIndex: index,
    );
  }

  Future<void> play() async {
    await _audioPlayer.play();
  }
}
