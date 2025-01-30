import 'dart:developer';

import 'package:just_audio/just_audio.dart';
import 'package:retip/app/data/providers/just_audio_provider.dart';
import 'package:retip/app/data/providers/on_audio_query_provider.dart';
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

class AudioRepositoryImplementation implements AudioRepository {
  // TODO remove this dependency after API cleanup
  final LibraryRepository libraryRepository;
  final SharedPreferencesProvider sharedPreferencesProvider;
  final JustAudioProvider justAudioProvider;
  final OnAudioQueryProvider onAudioQueryProvider;

  AudioRepositoryImplementation({
    required this.libraryRepository,
    required this.sharedPreferencesProvider,
    required this.justAudioProvider,
    required this.onAudioQueryProvider,
  });

  @override
  Future<void> init() async {
    try {
      final index = getTracksIndex();
      final tracks = await getTracksList();

      final keepPlayback = getKeepPlayback();

      if (keepPlayback == false) {
        await setTracksList([]);
      }

      if (tracks.isNotEmpty && keepPlayback) {
        await setPlaylist(tracks);
        await skipToIndex(index.clamp(0, tracks.length - 1));

        if (getAutoplay()) {
          play();
        }
      }

      await setShuffleMode(getShuffleMode());
      await setRepeatMode(getRepeatMode());
    } catch (e) {
      inspect(e);
    }
  }

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
    await justAudioProvider.setLoopMode(
      mode == AudioRepeatMode.all
          ? LoopMode.all
          : mode == AudioRepeatMode.one
              ? LoopMode.one
              : LoopMode.off,
    );
    return await sharedPreferencesProvider.setString(
      Keys.audioRepeatMode.name,
      mode.name,
    );
  }

  @override
  Future<bool> setShuffleMode(bool isEnabled) async {
    await justAudioProvider.setShuffleModeEnabled(isEnabled);
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

    if (await onAudioQueryProvider.permissionsStatus() == false ||
        await onAudioQueryProvider.permissionsRequest() == false) {
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

  @override
  Stream<bool> get playingStream => justAudioProvider.playingStream;

  @override
  Stream<AudioRepeatMode> get repeatModeStream {
    final mode = justAudioProvider.loopModeStream;
    return mode.map((event) {
      switch (event) {
        case LoopMode.off:
          return AudioRepeatMode.none;
        case LoopMode.one:
          return AudioRepeatMode.one;
        case LoopMode.all:
          return AudioRepeatMode.all;
      }
    });
  }

  @override
  Stream<bool> get shuffleModeStream {
    return justAudioProvider.shuffleModeEnabledStream;
  }
}
