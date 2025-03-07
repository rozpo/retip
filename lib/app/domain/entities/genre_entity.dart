import 'track_entity.dart';

abstract class GenreEntity {
  final int id;
  final List<TrackEntity> tracks;

  final String name;
  final String? photo;

  GenreEntity({
    this.tracks = const [],
    required this.name,
    required this.id,
    this.photo,
  });
}
