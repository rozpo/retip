import 'package:get_it/get_it.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/core/audio/retip_audio.dart';

mixin PlayAudio {
  static void call(
    List<TrackEntity> tracks, {
    bool? shuffle,
    int? index,
  }) async {
    final player = GetIt.I.get<RetipAudio>();

    await player.playlistAddAll(tracks, index);

    if (shuffle != null) {
      await player.setShuffleMode(shuffle);
    }

    player.play();
  }
}
