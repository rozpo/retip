import 'dart:typed_data';

abstract class TrackEntity {
  final String title;
  final String album;
  final String artist;
  final Uri uri;
  final Uint8List? artwork;

  TrackEntity({
    required this.title,
    required this.album,
    required this.artist,
    required this.uri,
    required this.artwork,
  });
}
