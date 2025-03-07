import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;

import '../../domain/entities/track_entity.dart';

class TrackModel implements TrackEntity {
  @override
  String artist;

  @override
  String title;

  TrackModel({
    required this.artist,
    required this.title,
  });

  factory TrackModel.fromOnAudioQuery(on_audio_query.SongModel data) {
    return TrackModel(
      artist: data.artist ?? '',
      title: data.title,
    );
  }
}
