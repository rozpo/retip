import 'package:objectbox/objectbox.dart';
import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;

import '../../domain/entites/album_entity.dart';

@Entity()
final class AlbumModel implements AlbumEntity {
  @Id()
  @override
  int id;

  @Unique()
  @override
  int albumId;

  @override
  int artistId;

  @override
  String title;

  @override
  String artist;

  AlbumModel({
    this.id = 0,
    required this.albumId,
    required this.artistId,
    required this.title,
    required this.artist,
  });

  factory AlbumModel.fromOnAudioQuery(on_audio_query.AlbumModel data) {
    return AlbumModel(
      albumId: data.id,
      artistId: data.artistId!,
      title: data.album,
      artist: data.artist!,
    );
  }
}
