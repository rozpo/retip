import 'package:objectbox/objectbox.dart';

import '../../../../../app/domain/entities/track_entity.dart';
import 'album_model.dart';
import 'artist_model.dart';
import 'genre_model.dart';

@Entity()
class TrackModel implements TrackEntity {
  @Id()
  @override
  int id;

  final ToOne<AlbumModel> albumDb = ToOne();

  final ToOne<ArtistModel> artistDb = ToOne();

  final ToOne<GenreModel> genreDb = ToOne();

  @override
  String title;

  @Unique()
  @override
  String location;

  @override
  bool isFavorite;

  TrackModel({
    this.isFavorite = false,
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

  @Transient()
  @override
  GenreModel? get genre => genreDb.target;
}
