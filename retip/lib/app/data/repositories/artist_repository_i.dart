import 'package:retip/app/data/models/artist_model.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/domain/enitities/artist_entity.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/repositories/artist_repository.dart';

final class ArtistRepositoryI implements ArtistRepository {
  final OnAudioQueryProvider _onAudioQueryProvider;

  const ArtistRepositoryI(OnAudioQueryProvider onAudioQueryProvider)
    : _onAudioQueryProvider = onAudioQueryProvider;

  @override
  Future<Result<List<ArtistEntity>>> getAll() async {
    try {
      final rawData = await _onAudioQueryProvider.getArtists();
      final data = rawData.map((e) => ArtistModel.fromOnAudioQueryProvider(e));

      return ResultSuccess(data.toList());
    } catch (e) {
      return ResultFailure.fromObject(e);
    }
  }
}
