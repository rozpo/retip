import '../entities/album_entity.dart';
import '../entities/artist_entity.dart';
import '../entities/track_entity.dart';

abstract class LibraryRepository {
  Future<List<TrackEntity>> getAllTracks();

  Future<List<AlbumEntity>> getAllAlbums();

  Future<List<ArtistEntity>> getAllArtists();

  Future<TrackEntity> getTrack(int id);

  Future<AlbumEntity> getAlbum(int id);

  Future<ArtistEntity> getArtist(int id);
}
