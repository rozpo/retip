import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;
import 'package:retip/app/services/entities/artist_entity.dart';

class ArtistModel extends ArtistEntity {
  ArtistModel._({
    required super.name,
    required super.artwork,
  });

  factory ArtistModel.fromArtistModel(
    on_audio_query.ArtistModel data,
    Uint8List? artwork,
  ) {
    try {
      return ArtistModel._(
        name: data.artist,
        artwork: artwork,
      );
    } catch (e) {
      throw ArgumentError();
    }
  }
}
