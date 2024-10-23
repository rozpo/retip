import 'dart:typed_data';

import 'package:retip/app/services/entities/abstract_entity.dart';
import 'package:retip/app/services/entities/album_entity.dart';

abstract class ArtistEntity extends AbstractEntity {
  final String name;
  final Uint8List? artwork;
  final List<AlbumEntity> albums;

  ArtistEntity({
    required this.name,
    required this.artwork,
    required this.albums,
  });

  @override
  String toString() {
    return name;
  }

  @override
  String header() {
    return name;
  }

  @override
  String description() {
    return albums.length.toString();
  }
}
