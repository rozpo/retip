import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;
import 'package:retip/app/data/models/album_model.dart';
import 'package:retip/app/domain/entities/artist_entity.dart';

class ArtistModel extends ArtistEntity {
  ArtistModel._({
    required super.id,
    required super.name,
    required super.artwork,
    required super.albums,
  });

  factory ArtistModel.fromArtistModel(
    on_audio_query.ArtistModel data,
    Uint8List? artwork,
    List<AlbumModel> albums,
  ) {
    try {
      return ArtistModel._(
        id: data.id,
        name: data.artist,
        artwork: artwork,
        albums: albums,
      );
    } catch (e) {
      throw ArgumentError();
    }
  }
}
