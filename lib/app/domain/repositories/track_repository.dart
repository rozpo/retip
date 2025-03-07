import '../entities/track_entity.dart';

abstract class TrackRepository {
  Stream<List<TrackEntity>> stream();

  void toggleFavorite(TrackEntity track);
}
