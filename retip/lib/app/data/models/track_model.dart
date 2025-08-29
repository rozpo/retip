import 'package:objectbox/objectbox.dart';
import 'package:retip/app/domain/entities/track_entity.dart';

@Entity()
final class TrackModel implements TrackEntity {
  @Id()
  @override
  int id;

  @Unique()
  @override
  int trackId;

  @override
  String title;

  @override
  String artist;

  TrackModel({
    this.id = 0,
    required this.trackId,
    required this.title,
    required this.artist,
  });
}
