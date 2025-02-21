import 'package:objectbox/objectbox.dart';

import '../../domain/entities/album_entity.dart';
import 'artist_model.dart';
import 'track_model.dart';

@Entity()
class AlbumModel implements AlbumEntity {
  @Id()
  @override
  int id;

  final ToOne<ArtistModel> artistModel = ToOne();

  @Backlink('albumModel')
  final ToMany<TrackModel> tracksModel = ToMany();

  @override
  String title;

  @override
  String? artwork;

  AlbumModel({
    this.id = 0,
    required this.title,
    this.artwork,
  });

  @Transient()
  @override
  ArtistModel? get artist => artistModel.target;

  @Transient()
  @override
  List<TrackModel> get tracks => tracksModel.toList();
}
