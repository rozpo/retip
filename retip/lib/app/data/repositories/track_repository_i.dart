import 'package:retip/app/data/models/track_model.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/repositories/track_repository.dart';

final class TrackRepositoryI implements TrackRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;

  const TrackRepositoryI(OnAudioQueryProvider onAudioQueryProvider)
    : _onAudioQueryProvider = onAudioQueryProvider;

  @override
  Future<Result<List<TrackEntity>>> getAll() async {
    try {
      final rawData = await _onAudioQueryProvider.getAllSongs();
      final data = rawData.map((e) => TrackModel.fromOnAudioQueryProvider(e));

      return ResultSuccess(data.toList());
    } catch (e) {
      return ResultFailure.fromObject(e);
    }
  }

  @override
  Future<Result<List<TrackEntity>>> getByAlbum(int id) async {
    try {
      final rawData = await _onAudioQueryProvider.getAlbumSongs(id);
      final data = rawData.map((e) => TrackModel.fromOnAudioQueryProvider(e));

      return ResultSuccess(data.toList());
    } catch (e) {
      return ResultFailure.fromObject(e);
    }
  }
}
