import 'package:retip/app/data/models/artist_model.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/services/repositories/artist_repository.dart';

class OnAudioQueryArtistRepository implements ArtistRepository {
  final _onAudioQueryProvider = OnAudioQueryProvider();

  @override
  Future<List<ArtistEntity>> getAll() async {
    final data = await _onAudioQueryProvider.getAllArtists();
    final artists = <ArtistModel>[];

    for (final element in data) {
      final artwork = await _onAudioQueryProvider.getArtistArtwork(element.id);
      artists.add(ArtistModel.fromArtistModel(element, artwork));
    }

    return artists;
  }
}
