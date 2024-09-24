import 'dart:typed_data';

abstract class ArtistEntity {
  final String name;
  final Uint8List? artwork;

  ArtistEntity({
    required this.name,
    required this.artwork,
  });
}
