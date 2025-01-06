import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;
import 'package:retip/app/data/models/track_model.dart';
import 'package:retip/app/domain/entities/album_entity.dart';

class AlbumModel extends AlbumEntity {
  AlbumModel._({
    required super.id,
    required super.title,
    required super.artwork,
    required super.tracks,
    super.artistId,
    required super.artist,
    required super.year,
  });

  factory AlbumModel.fromAlbumModel(
    on_audio_query.AlbumModel data,
    Uint8List? artwork,
    List<TrackModel> tracks,
  ) {
    try {
      return AlbumModel._(
        id: data.id,
        title: data.album,
        artist: data.artist ?? '',
        artistId: data.artistId,
        artwork: artwork,
        tracks: tracks,
        year: data.getMap['maxyear'] ?? data.getMap['minyear'],
      );
    } catch (e) {
      throw ArgumentError();
    }
  }
}
