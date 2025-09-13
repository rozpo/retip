import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/domain/errors/result.dart';

abstract interface class AudioService {
  Future<Result<void>> setQueue(List<TrackEntity> tracks, {int? index});

  Future<Result<void>> addToQueue(List<TrackEntity> tracks);

  Result<void> play();

  Result<void> pause();

  Stream<int?> indexStream();

  Stream<Duration> positionStream();

  Stream<Duration> durationStream();
}
