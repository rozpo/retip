import 'package:get_it/get_it.dart';
import 'package:retip/app/data/providers/retip_audio.dart';
import 'package:retip/app/domain/entities/track_entity.dart';

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

    await player.playlistAddAll(tracks, index);

    player.play();
  }
}
