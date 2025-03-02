import 'package:objectbox/objectbox.dart';

import '../../domain/entities/playlist_entity.dart';
import 'track_model.dart';

@Entity()
class PlaylistModel implements PlaylistEntity {
  @Id()
  @override
  int id;

  final tracksDb = ToMany<TrackModel>();

  @override
  String name;

  @override
  String? photo;

  PlaylistModel({
    required this.name,
    this.id = 0,
    this.photo,
  });

  @Transient()
  @override
  List<TrackModel> get tracks => tracksDb.toList();
}
