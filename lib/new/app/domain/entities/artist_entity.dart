import 'album_entity.dart';
import 'track_entity.dart';

abstract class ArtistEntity {
  final int id;
  final List<AlbumEntity> albums;
  final List<TrackEntity> tracks;

  final String name;
  final String? photo;

  ArtistEntity({
    this.albums = const [],
    this.tracks = const [],
    required this.name,
    required this.id,
    this.photo,
  });
}
