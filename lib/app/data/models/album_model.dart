import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;
import 'package:retip/app/services/entities/album_entity.dart';

class AlbumModel extends AlbumEntity {
  AlbumModel._({
    required super.title,
    required super.artist,
    required super.artwork,
  });

  factory AlbumModel.fromSongModel(
    on_audio_query.AlbumModel data,
    Uint8List? artwork,
  ) {
    try {
      return AlbumModel._(
        title: data.album,
        artist: data.artist ?? '',
        artwork: artwork,
      );
    } catch (e) {
      throw ArgumentError();
    }
  }
}
