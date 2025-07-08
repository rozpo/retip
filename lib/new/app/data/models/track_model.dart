import 'package:objectbox/objectbox.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../domain/entities/track_entity.dart';

@Entity()
final class TrackModel implements TrackEntity {
  @Id()
  @override
  int id;

  @Unique()
  @override
  int trackId;

  @override
  int albumId;

  @override
  int artistId;

  @override
  String title;

  @override
  String album;

  @override
  String artist;

  TrackModel({
    this.id = 0,
    required this.trackId,
    required this.albumId,
    required this.artistId,
    required this.title,
    required this.album,
    required this.artist,
  });

  factory TrackModel.fromOnAudioQuery(SongModel song) {
    return TrackModel(
      trackId: song.id,
      albumId: song.albumId!,
      artistId: song.artistId!,
      title: song.title,
      album: song.album!,
      artist: song.artist!,
    );
  }
}
