import 'package:objectbox/objectbox.dart';

import '../../domain/entities/album_entity.dart';

@Entity()
class AlbumModel implements AlbumEntity {
  @Id()
  @override
  int id;

  @override
  String title;

  @override
  String artist;

  @override
  String? artwork;

  AlbumModel({
    this.id = 0,
    required this.title,
    required this.artist,
    this.artwork,
  });
}
