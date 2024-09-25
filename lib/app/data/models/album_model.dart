import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;
import 'package:retip/app/data/models/track_model.dart';
import 'package:retip/app/services/entities/album_entity.dart';

class AlbumModel extends AlbumEntity {
  AlbumModel._({
    required super.title,
    required super.artist,
    required super.artwork,
    required super.tracks,
  });

  factory AlbumModel.fromAlbumModel(
    on_audio_query.AlbumModel data,
    Uint8List? artwork,
    List<TrackModel> tracks,
  ) {
    try {
      return AlbumModel._(
        title: data.album,
        artist: data.artist ?? '',
        artwork: artwork,
        tracks: tracks,
      );
    } catch (e) {
      throw ArgumentError();
    }
  }
}
