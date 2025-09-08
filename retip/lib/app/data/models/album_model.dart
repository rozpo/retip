import 'package:retip/app/domain/enitities/album_entity.dart';
import 'package:on_audio_query/on_audio_query.dart' as on_audio_query;

final class AlbumModel extends AlbumEntity {
  const AlbumModel({
    required super.artistId,
    required super.albumId,
    required super.artist,
    required super.title,
  });

  factory AlbumModel.fromOnAudioQueryProvider(on_audio_query.AlbumModel album) {
    return AlbumModel(
      artistId: album.artistId!,
      artist: album.artist!,
      title: album.album,
      albumId: album.id,
    );
  }
}
