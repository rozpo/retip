import 'package:flutter/material.dart';

@immutable
abstract class ArtistEntity {
  final int artistId;

  final String name;

  const ArtistEntity({required this.artistId, required this.name});
}
