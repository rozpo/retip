import 'dart:typed_data';

import 'package:retip/app/services/entities/track_entity.dart';

abstract class AlbumEntity {
  final String title;
  final String artist;
  final Uint8List? artwork;

  final List<TrackEntity> tracks;

  AlbumEntity({
    required this.title,
    required this.artist,
    required this.artwork,
    required this.tracks,
  });

  @override
  String toString() {
    return title;
  }
}
