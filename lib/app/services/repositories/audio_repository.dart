import 'package:retip/app/services/entities/track_entity.dart';

enum AudioRepeatMode {
  /// Repeat audio queue when reach end of list.
  all,

  /// Repeat current audio only.
  one,

  /// Do not repeat audio queue on finish.
  none;

  /// Parse [String] to [AudioRepeatMode] enum.
  ///
  /// Return parsed [AudioRepeatMode] or [AudioRepeatMode.none] as fallback.
  static AudioRepeatMode fromString(String name) {
    return AudioRepeatMode.values.firstWhere(
      (element) => element.name == name,
      orElse: () => AudioRepeatMode.none,
    );
  }
}

abstract class AudioRepository {
  /// Set shuffle mode for playback to persistency.
  ///
  /// Return [true] when successful, otherwise [false].
  Future<bool> setShuffleMode(bool isEnabled);

  /// Get shuffle mode playback from persistency.
  ///
  /// Return [true] for enabled, [false] for disabled mode/fallback.
  bool getShuffleMode();

  /// Save [AudioRepeatMode] to persistency.
  ///
  /// Return [true] when successful, otherwise [false].
  Future<bool> setRepeatMode(AudioRepeatMode mode);

  /// Get [AudioRepeatMode] playback from persistency.
  ///
  /// Return [AudioRepeatMode.none] as fallback.
  AudioRepeatMode getRepeatMode();

  Future<bool> setTracksIndex(int index);

  int getTracksIndex();

  Future<bool> setTracksList(List<TrackEntity> tracks);

  Future<List<TrackEntity>> getTracksList();
}
