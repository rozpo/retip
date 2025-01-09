import 'package:retip/app/data/providers/just_audio_provider.dart';
import 'package:retip/app/data/providers/retip_permission.dart';
import 'package:retip/app/data/providers/shared_preferences_provider.dart';
import 'package:retip/app/domain/entities/track_entity.dart';
import 'package:retip/app/domain/repositories/audio_repository.dart';
import 'package:retip/app/domain/repositories/library_repository.dart';

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
  final JustAudioProvider justAudioProvider;

  AudioRepositoryImplementation({
    required this.libraryRepository,
    required this.sharedPreferencesProvider,
    required this.justAudioProvider,
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

  @override
  Future<void> play() async {
    await justAudioProvider.play();
  }

  @override
  Future<void> pause() async {
    await justAudioProvider.pause();
  }

  @override
  Future<void> seekTo(Duration position) async {
    await justAudioProvider.seek(position);
  }

  @override
  Future<void> setPlaylist(List<TrackEntity> tracks, [int index = 0]) async {
    // Set the playlist to the just audio provider
    await justAudioProvider.setPlaylist(tracks, index);
    // Save the tracks list to the shared preferences
    setTracksList(tracks);
  }

  @override
  Future<void> skipToIndex(int index) async {
    await justAudioProvider.seek(Duration.zero, index: index);
  }

  @override
  Future<void> skipToNext() async {
    await justAudioProvider.seekToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    await justAudioProvider.seekToPrevious();
  }

  @override
  Future<void> stop() async {
    await justAudioProvider.stop();
  }
}
