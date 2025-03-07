import '../entities/track_entity.dart';

abstract class AudioRepository {
  Future<void> play(List<TrackEntity> tracks, int index);
  Future<void> pause();
}
