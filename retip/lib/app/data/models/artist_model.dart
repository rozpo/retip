import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;
import 'package:retip/app/domain/enitities/artist_entity.dart';

final class ArtistModel extends ArtistEntity {
  const ArtistModel({required super.artistId, required super.name});

  factory ArtistModel.fromOnAudioQueryProvider(
    on_audio_query.ArtistModel artist,
  ) {
    return ArtistModel(artistId: artist.id, name: artist.artist);
  }
}
