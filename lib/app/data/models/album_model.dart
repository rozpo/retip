import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;
import 'package:retip/app/data/models/track_model.dart';
import 'package:retip/app/services/entities/album_entity.dart';

import 'artist_model.dart';

class AlbumModel extends AlbumEntity {
  AlbumModel._({
    required super.title,
    required super.artwork,
    required super.tracks,
    super.artist,
  });

  factory AlbumModel.fromAlbumModel(
    on_audio_query.AlbumModel data,
    Uint8List? artwork,
    List<TrackModel> tracks, [
    on_audio_query.ArtistModel? artist,
  ]) {
    try {
      return AlbumModel._(
        title: data.album,
        artist: artist != null
            ? ArtistModel.fromArtistModel(artist, artwork, [])
            : null,
        artwork: artwork,
        tracks: tracks,
      );
    } catch (e) {
      throw ArgumentError();
    }
  }
}
