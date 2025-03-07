import 'artist_entity.dart';
import 'track_entity.dart';

abstract class AlbumEntity {
  final int id;
  final ArtistEntity? artist;
  final List<TrackEntity> tracks;

  final String title;
  final String? artwork;

  final bool isFavorite;

  AlbumEntity({
    this.isFavorite = false,
    this.tracks = const [],
    required this.artist,
    required this.title,
    required this.id,
    this.artwork,
  });
}
