import 'package:objectbox/objectbox.dart';

import '../../domain/entities/artist_entity.dart';
import 'album_model.dart';
import 'track_model.dart';

@Entity()
class ArtistModel implements ArtistEntity {
  @Id()
  @override
  int id;

  @Backlink('artistDb')
  final albumsDb = ToMany<AlbumModel>();

  @Backlink('artistDb')
  final tracksDb = ToMany<TrackModel>();

  @override
  String name;

  @override
  String? photo;

  @override
  bool isFavorite;

  ArtistModel({
    this.isFavorite = false,
    required this.name,
    this.id = 0,
  });

  @override
  List<AlbumModel> get albums => albumsDb.toList();

  @override
  List<TrackModel> get tracks => tracksDb.toList();
}
