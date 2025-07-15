import 'package:objectbox/objectbox.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../domain/entites/track_entity.dart';

@Entity()
final class TrackModel implements TrackEntity {
  @Id()
  @override
  int id;

  @Unique()
  @override
  int trackId;

  @override
  String title;

  @override
  String album;

  @override
  String artist;

  @Unique()
  @override
  String location;

  TrackModel({
    this.id = 0,
    required this.trackId,
    required this.title,
    required this.album,
    required this.artist,
    required this.location,
  });

  factory TrackModel.fromOnAudioQuery(SongModel data) {
    return TrackModel(
      trackId: data.id,
      title: data.title,
      album: data.album!,
      artist: data.artist!,
      location: data.uri!,
    );
  }
}
