import 'package:flutter/widgets.dart';

@immutable
abstract class TrackEntity {
  final int trackId;
  final String title;
  final String album;
  final String artist;

  const TrackEntity({
    required this.trackId,
    required this.artist,
    required this.album,
    required this.title,
  });
}
