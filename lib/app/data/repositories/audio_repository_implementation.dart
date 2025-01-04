import 'package:retip/app/data/providers/shared_preferences_provider.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/services/repositories/audio_repository.dart';
import 'package:retip/app/services/repositories/library_repository.dart';
import 'package:retip/core/permission/retip_permission.dart';

enum Keys {
  audioRepeatMode,
  audioShuffleMode,
  audioTracksIndex,
  audioTracksList,
  audioAutoplay,
  audioKeepPlayback,
}

class AudioRepositoryImplementation extends AudioRepository {
  // TODO remove this dependency after API cleanup
  final LibraryRepository libraryRepository;
  final SharedPreferencesProvider sharedPreferencesProvider;

  AudioRepositoryImplementation({
    required this.libraryRepository,
    required this.sharedPreferencesProvider,
  });

  @override
  AudioRepeatMode getRepeatMode() {
    final mode = sharedPreferencesProvider.getString(Keys.audioRepeatMode.name);

    return AudioRepeatMode.fromString(mode ?? '');
  }

  @override
  bool getShuffleMode() {
    return sharedPreferencesProvider.getBool(Keys.audioShuffleMode.name);
  }

  @override
  Future<bool> setRepeatMode(AudioRepeatMode mode) async {
    return await sharedPreferencesProvider.setString(
      Keys.audioRepeatMode.name,
      mode.name,
    );
  }

  @override
  Future<bool> setShuffleMode(bool isEnabled) async {
    return await sharedPreferencesProvider.setBool(
      Keys.audioShuffleMode.name,
      isEnabled,
    );
  }

  @override
  Future<bool> setTracksIndex(int index) async {
    return await sharedPreferencesProvider.setInt(
      Keys.audioTracksIndex.name,
      index,
    );
  }

  @override
  int getTracksIndex() {
    return sharedPreferencesProvider.getInt(Keys.audioTracksIndex.name);
  }

  @override
  Future<bool> setTracksList(List<TrackEntity> tracks) async {
    final trackIds = tracks.map((e) => e.id.toString()).toList();

    return await sharedPreferencesProvider.setStringList(
      Keys.audioTracksList.name,
      trackIds,
    );
  }

  @override
  Future<List<TrackEntity>> getTracksList() async {
    final trackIds =
        sharedPreferencesProvider.getStringList(Keys.audioTracksList.name) ??
            [];

    if (await RetipPermission.checkAndRequest() == false) {
      return [];
    }

    final allTracks = await libraryRepository.getAllTracks();

    final playerTracks =
        allTracks.where((e) => trackIds.contains(e.id.toString())).toList();

    return playerTracks;
  }

  @override
  bool getAutoplay() {
    return sharedPreferencesProvider.getBool(Keys.audioAutoplay.name);
  }

  @override
  bool getKeepPlayback() {
    return sharedPreferencesProvider.getBool(Keys.audioKeepPlayback.name);
  }

  @override
  Future<bool> setAutoplay(bool autoplay) async {
    return await sharedPreferencesProvider.setBool(
      Keys.audioAutoplay.name,
      autoplay,
    );
  }

  @override
  Future<bool> setKeepPlayback(bool keepPlayback) async {
    return await sharedPreferencesProvider.setBool(
      Keys.audioKeepPlayback.name,
      keepPlayback,
    );
  }
}
