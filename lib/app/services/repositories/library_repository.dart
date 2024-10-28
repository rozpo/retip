import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/services/entities/track_entity.dart';

abstract class LibraryRepository {
  Future<List<TrackEntity>> getAllTracks();

  Future<List<AlbumEntity>> getAllAlbums();

  Future<List<ArtistEntity>> getAllArtists();
}
