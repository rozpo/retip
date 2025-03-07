import 'package:objectbox/objectbox.dart';
import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;

import '../../domain/entities/album_entity.dart';
import 'artist_model.dart';
import 'track_model.dart';

@Entity()
class AlbumModel implements AlbumEntity {
  @Id()
  @override
  int id;

  final ToOne<ArtistModel> artistDb = ToOne();

  @Backlink('albumDb')
  final ToMany<TrackModel> tracksDb = ToMany();

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
  ArtistModel? get artist => artistDb.target;

  @Transient()
  @override
  List<TrackModel> get tracks => tracksDb.toList();

  factory AlbumModel.fromOnAudioQuery(on_audio_query.AlbumModel data) {
    return AlbumModel(
      title: data.album,
    );
  }
}
