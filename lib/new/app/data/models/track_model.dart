import 'package:objectbox/objectbox.dart';

import '../../domain/entities/track_entity.dart';
import 'album_model.dart';
import 'artist_model.dart';

@Entity()
class TrackModel implements TrackEntity {
  @Id()
  @override
  int id;

  final ToOne<AlbumModel> albumDb = ToOne();

  final ToOne<ArtistModel> artistDb = ToOne();

  @override
  String title;

  @Unique()
  @override
  String location;

  TrackModel({
    required this.location,
    required this.title,
    this.id = 0,
  });

  @Transient()
  @override
  AlbumModel? get album => albumDb.target;

  @Transient()
  @override
  ArtistModel? get artist => artistDb.target;
}
