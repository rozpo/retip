import '../entities/track_entity.dart';

abstract class LibraryRepository {
  Future<void> scan();

  Stream<List<TrackEntity>> tracksStream();
}
