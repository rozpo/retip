import 'dart:typed_data';

import 'package:flutter/foundation.dart';
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
    required super.size,
    super.genre,
    super.composer,
    super.dateAdded,
    super.dateModified,
    required super.fileType,
    super.isAlarm,
    super.isAudioBook,
    super.isMusic,
    super.isNotification,
    super.isPodcast,
    super.isRingtone,
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
        size: data.size,
        genre: data.genre,
        composer: data.composer,
        dateAdded: data.dateAdded != null
            ? DateTime.fromMillisecondsSinceEpoch(data.dateAdded!)
            : null,
        dateModified: data.dateModified != null
            ? DateTime.fromMillisecondsSinceEpoch(data.dateModified!)
            : null,
        fileType: data.fileExtension,
        isAlarm: data.isAlarm,
        isAudioBook: data.isAudioBook,
        isMusic: data.isMusic,
        isNotification: data.isNotification,
        isPodcast: data.isPodcast,
        isRingtone: data.isRingtone,
      );
    } catch (e) {
      throw ArgumentError();
    }
  }
}
