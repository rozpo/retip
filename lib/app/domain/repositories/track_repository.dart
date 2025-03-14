import '../entities/track_entity.dart';

abstract class TrackRepository {
  Stream<List<TrackEntity>> streamAll();

  Stream<List<TrackEntity>> streamByGenre(int genreId);

  Stream<List<TrackEntity>> streamByAlbum(int albumId);

  Stream<List<TrackEntity>> streamByArtist(int artistId);

  void toggleFavorite(TrackEntity track);

  Stream<TrackEntity?> trackStream(int id);
}
