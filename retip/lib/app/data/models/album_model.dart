import 'package:objectbox/objectbox.dart';

import '../../domain/entities/album_entity.dart';

@Entity()
final class AlbumModel implements AlbumEntity {
  @Id()
  @override
  int id;

  @Unique()
  @override
  int albumId;

  @override
  String title;

  @override
  String artist;

  AlbumModel({
    this.id = 0,
    required this.albumId,
    required this.title,
    required this.artist,
  });
}
