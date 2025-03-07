import '../entities/track_entity.dart';

abstract class AudioRepository {
  Future<void> play(List<TrackEntity> tracks, int index);
  Future<void> pause();
  Future<void> resume();

  Future<void> next();
  Future<void> previous();

  Stream<int> get index;
  Stream<bool> get isPlaying;
  Stream<Duration> get position;
  Stream<Duration> get duration;
}
