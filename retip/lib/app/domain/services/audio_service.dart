import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/domain/errors/result.dart';

abstract interface class AudioService {
  Future<Result<void>> load(List<TrackEntity> tracks, {int? index});

  Result<void> play();

  Result<void> pause();
}
