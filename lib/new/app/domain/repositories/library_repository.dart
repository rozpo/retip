import '../entities/album_entity.dart';
import '../entities/artist_entity.dart';
import '../entities/genre_entity.dart';
import '../entities/track_entity.dart';

abstract class LibraryRepository {
  Future<void> scan();

  Stream<List<TrackEntity>> tracksStream();

  Stream<List<AlbumEntity>> albumsStream();

  Stream<List<ArtistEntity>> artistsStream();

  Stream<List<GenreEntity>> genresStream();
}
