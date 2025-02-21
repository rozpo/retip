import 'package:objectbox/objectbox.dart';

import '../../domain/entities/track_entity.dart';
import 'album_model.dart';
import 'artist_model.dart';

@Entity()
class TrackModel implements TrackEntity {
  @Id()
  @override
  int id;

  final ToOne<AlbumModel> albumModel = ToOne();

  final ToOne<ArtistModel> artistModel = ToOne();

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
  AlbumModel? get album => albumModel.target;

  @Transient()
  @override
  ArtistModel? get artist => artistModel.target;
}
