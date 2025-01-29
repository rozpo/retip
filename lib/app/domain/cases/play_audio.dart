import 'package:get_it/get_it.dart';
import 'package:retip/app/data/providers/just_audio_provider.dart';
import 'package:retip/app/domain/entities/track_entity.dart';

mixin PlayAudio {
  static void call(
    List<TrackEntity> tracks, {
    bool? shuffle,
    int? index,
  }) async {
    final player = GetIt.I.get<JustAudioProvider>();

    if (shuffle != null) {
      await player.setShuffleMode(shuffle);
    }

    await player.playlistAddAll(tracks, index);

    player.play();
  }
}
