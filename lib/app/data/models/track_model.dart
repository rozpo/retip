import 'package:objectbox/objectbox.dart';
import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;

import '../../domain/entities/track_entity.dart';

@Entity()
class TrackModel implements TrackEntity {
  @Id()
  @override
  int id;

  @override
  String artist;

  @override
  String title;

  @Unique()
  @override
  String location;

  TrackModel({
    this.id = 0,
    required this.artist,
    required this.title,
    required this.location,
  });

  factory TrackModel.fromOnAudioQuery(on_audio_query.SongModel data) {
    return TrackModel(
      artist: data.artist ?? '',
      title: data.title,
      location: data.uri!,
    );
  }
}
