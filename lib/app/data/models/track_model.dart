import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:retip/app/services/entities/track_entity.dart';

class TrackModel extends TrackEntity {
  TrackModel._({
    required super.title,
    required super.album,
    required super.artist,
    required super.uri,
    required super.artwork,
  });

  factory TrackModel.fromSongModel(SongModel data, Uint8List? artwork) {
    try {
      return TrackModel._(
        title: data.title,
        album: data.album ?? '',
        artist: data.artist ?? '',
        uri: Uri.parse(data.uri ?? ''),
        artwork: artwork,
      );
    } catch (e) {
      throw ArgumentError();
    }
  }
}
