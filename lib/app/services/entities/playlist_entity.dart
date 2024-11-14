import 'dart:typed_data';

import 'package:retip/app/services/entities/abstract_entity.dart';
import 'package:retip/app/services/entities/track_entity.dart';

class PlaylistEntity extends AbstractEntity {
  String name;
  List<TrackEntity> tracks;

  PlaylistEntity({
    required super.id,
    required this.name,
    this.tracks = const [],
  });

  Uint8List? get artwork {
    for (final track in tracks) {
      if (track.artwork != null) {
        return track.artwork;
      }
    }
    return null;
  }
}
