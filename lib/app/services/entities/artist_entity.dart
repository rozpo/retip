import 'dart:typed_data';

import 'package:retip/app/services/entities/album_entity.dart';

abstract class ArtistEntity {
  final String name;
  final Uint8List? artwork;
  final List<AlbumEntity> albums;

  ArtistEntity({
    required this.name,
    required this.artwork,
    required this.albums,
  });
}
