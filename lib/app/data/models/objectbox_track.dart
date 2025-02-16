import 'package:objectbox/objectbox.dart';

import '../../domain/entities/track.dart';

@Entity()
class ObjectboxTrack implements Track {
  @Id()
  @override
  int id;

  @override
  String artist;

  @override
  String album;

  @override
  String title;

  @Unique()
  @override
  String location;

  @override
  String? artwork;

  ObjectboxTrack({
    this.id = 0,
    required this.artist,
    required this.album,
    required this.title,
    required this.location,
    this.artwork,
  });
}
