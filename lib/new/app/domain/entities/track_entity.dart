import 'album_entity.dart';
import 'artist_entity.dart';
import 'genre_entity.dart';

abstract class TrackEntity {
  final int id;
  final AlbumEntity? album;
  final ArtistEntity? artist;
  final GenreEntity? genre;

  final String title;
  final String location;

  TrackEntity({
    required this.location,
    required this.title,
    required this.id,
    this.artist,
    this.album,
    this.genre,
  });
}
