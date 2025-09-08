import 'package:on_audio_query/on_audio_query.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';

final class TrackModel extends TrackEntity {
  const TrackModel({
    required super.artistId,
    required super.albumId,
    required super.trackId,
    required super.artist,
    required super.album,
    required super.title,
  });

  factory TrackModel.fromOnAudioQueryProvider(SongModel song) {
    return TrackModel(
      artistId: song.artistId!,
      albumId: song.albumId!,
      artist: song.artist!,
      album: song.album!,
      title: song.title,
      trackId: song.id,
    );
  }
}
