import 'package:flutter/material.dart';

@immutable
abstract class TrackEntity {
  final int artistId;
  final int albumId;
  final int trackId;

  final String title;
  final String album;
  final String artist;
  final Uri location;

  const TrackEntity({
    required this.artistId,
    required this.location,
    required this.albumId,
    required this.trackId,
    required this.artist,
    required this.album,
    required this.title,
  });
}
