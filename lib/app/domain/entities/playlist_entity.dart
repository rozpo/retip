import 'track_entity.dart';

abstract class PlaylistEntity {
  final int id;
  final List<TrackEntity> tracks;

  final String name;
  final String? photo;
  final bool isFavorite;

  PlaylistEntity({
    this.isFavorite = false,
    this.tracks = const [],
    required this.name,
    required this.id,
    this.photo,
  });
}
