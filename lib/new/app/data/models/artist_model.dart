import 'package:objectbox/objectbox.dart';

import '../../domain/entities/artist_entity.dart';
import 'album_model.dart';
import 'track_model.dart';

@Entity()
class ArtistModel implements ArtistEntity {
  @Id()
  @override
  int id;

  @Backlink('artistModel')
  final albumsModel = ToMany<AlbumModel>();

  @Backlink('artistModel')
  final tracksModel = ToMany<TrackModel>();

  @override
  String name;

  ArtistModel({
    this.id = 0,
    required this.name,
  });

  @override
  List<AlbumModel> get albums => albumsModel.toList();

  @override
  List<TrackModel> get tracks => tracksModel.toList();
}
