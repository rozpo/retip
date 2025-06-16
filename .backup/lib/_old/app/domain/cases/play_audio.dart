import 'package:get_it/get_it.dart';
import '../entities/track_entity.dart';
import '../repositories/audio_repository.dart';

mixin PlayAudio {
  static void call(
    List<TrackEntity> tracks, {
    bool? shuffle,
    int? index,
  }) async {
    final repository = GetIt.I.get<AudioRepository>();

    if (shuffle != null) {
      await repository.setShuffleMode(shuffle);
    }

    await repository.setPlaylist(tracks, index);

    repository.play();
  }
}
