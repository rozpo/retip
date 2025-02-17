import 'package:objectbox/objectbox.dart';

import '../../domain/entities/track_entity.dart';

@Entity()
class TrackModel implements TrackEntity {
  @Id()
  @override
  int id;

  @override
  String title;

  @override
  String album;

  @override
  String artist;

  @Unique()
  @override
  String location;

  TrackModel({
    this.id = 0,
    required this.album,
    required this.artist,
    required this.title,
    required this.location,
  });
}
