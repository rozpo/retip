import 'package:objectbox/objectbox.dart';

import '../../domain/entities/genre_entity.dart';
import 'track_model.dart';

@Entity()
class GenreModel implements GenreEntity {
  @override
  int id;

  @Backlink('genreDb')
  final tracksDb = ToMany<TrackModel>();

  @override
  String name;

  @override
  String? photo;

  GenreModel({
    required this.name,
    this.id = 0,
    this.photo,
  });

  @Transient()
  @override
  List<TrackModel> get tracks => tracksDb.toList();
}
