import 'package:objectbox/objectbox.dart';

import '../../domain/entites/playlist_entity.dart';

@Entity()
final class PlaylistModel implements PlaylistEntity {
  @Id()
  @override
  int id;

  @override
  String name;

  PlaylistModel({
    this.id = 0,
    required this.name,
  });
}
