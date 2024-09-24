import 'dart:typed_data';

abstract class AlbumEntity {
  final String title;
  final String artist;
  final Uint8List? artwork;

  AlbumEntity({
    required this.title,
    required this.artist,
    required this.artwork,
  });
}
