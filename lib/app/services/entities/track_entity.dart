import 'dart:typed_data';

abstract class TrackEntity {
  final int id;
  final String title;
  final String album;
  final String artist;
  final Uri uri;
  final Uint8List? artwork;
  final int? index;

  bool isFavourite = false;

  TrackEntity({
    required this.id,
    required this.title,
    required this.album,
    required this.artist,
    required this.uri,
    required this.artwork,
    this.index,
  });

  @override
  String toString() {
    return title;
  }
}
