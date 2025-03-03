import '../../../../../app/domain/entities/track_entity.dart';

abstract class TrackRepository {
  Future<void> scan();

  Stream<List<TrackEntity>> allStream();

  Stream<List<TrackEntity>> byAlbumStream(int albumId);

  Stream<List<TrackEntity>> byArtistStream(int artistId);

  Stream<List<TrackEntity>> byGenreStream(int genreId);

  Future<void> toggleFavorite(int id);
}
