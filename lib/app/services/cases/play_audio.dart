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

    if (shuffle != null) {
      await player.setShuffleMode(shuffle);
    }

    await player.playlistAddAll(tracks);

    if (index != null) {
      await player.seekToIndex(index);
    }

    player.play();
  }
}
