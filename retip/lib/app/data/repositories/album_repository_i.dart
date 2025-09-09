import 'package:retip/app/data/models/album_model.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/domain/enitities/album_entity.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/repositories/album_repository.dart';

final class AlbumRepositoryI implements AlbumRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;

  const AlbumRepositoryI(OnAudioQueryProvider onAudioQueryProvider)
    : _onAudioQueryProvider = onAudioQueryProvider;

  @override
  Future<Result<List<AlbumEntity>>> getAll() async {
    try {
      final rawData = await _onAudioQueryProvider.getAllAlbums();
      final data = rawData.map((e) => AlbumModel.fromOnAudioQueryProvider(e));

      return ResultSuccess(data.toList());
    } catch (e) {
      return ResultFailure.fromObject(e);
    }
  }
}
