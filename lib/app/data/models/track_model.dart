import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:retip/app/services/entities/track_entity.dart';

class TrackModel extends TrackEntity {
  TrackModel._({
    required super.id,
    super.albumId,
    required super.title,
    required super.album,
    required super.artist,
    super.artistId,
    required super.uri,
    required super.duration,
    super.artwork,
    super.index,
  });

  factory TrackModel.fromSongModel(SongModel data, Uint8List? artwork) {
    try {
      return TrackModel._(
        id: data.id,
        title: data.title,
        albumId: data.albumId,
        album: data.album ?? '',
        artist: data.artist ?? '',
        artistId: data.artistId,
        uri: Uri.parse(data.uri ?? ''),
        artwork: artwork,
        index: data.track,
        duration: Duration(milliseconds: data.duration ?? 0),
      );
    } catch (e) {
      throw ArgumentError();
    }
  }
}
