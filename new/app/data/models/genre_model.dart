import 'package:objectbox/objectbox.dart';
import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;

import '../../domain/entites/genre_entity.dart';

@Entity()
final class GenreModel implements GenreEntity {
  @override
  int genreId;

  @override
  int id;

  @override
  String name;

  GenreModel({
    this.id = 0,
    required this.genreId,
    required this.name,
  });

  factory GenreModel.fromOnAudioQuery(on_audio_query.GenreModel data) {
    return GenreModel(
      genreId: data.id,
      name: data.genre,
    );
  }
}
