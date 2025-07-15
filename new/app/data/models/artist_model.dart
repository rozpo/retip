import 'package:objectbox/objectbox.dart';
import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;

import '../../domain/entites/artist_entity.dart';

@Entity()
final class ArtistModel implements ArtistEntity {
  @Id()
  @override
  int id;

  @Unique()
  @override
  int artistId;

  @override
  String name;

  ArtistModel({
    this.id = 0,
    required this.artistId,
    required this.name,
  });

  factory ArtistModel.fromOnAudioQuery(on_audio_query.ArtistModel data) {
    return ArtistModel(
      artistId: data.id,
      name: data.artist,
    );
  }
}
