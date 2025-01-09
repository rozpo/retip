import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'package:retip/app/domain/entities/track_entity.dart';
import 'package:retip/app/domain/repositories/audio_repository.dart';

class RetipAudio extends AudioPlayer {
  ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(
    children: [],
  );

  List<TrackEntity> tracks = [];

  Future<void> init() async {
    final audio = GetIt.I.get<AudioRepository>();

    final index = audio.getTracksIndex();
    final tracks = await audio.getTracksList();

    final keepPlayback = audio.getKeepPlayback();

    if (keepPlayback == false) {
      await audio.setTracksList([]);
    }

    if (tracks.isNotEmpty && keepPlayback) {
      await playlistAddAll(tracks);
      await seekToIndex(index);

      if (audio.getAutoplay()) {
        play();
      }
    }

    await setShuffleMode(audio.getShuffleMode());
    await setRepeatMode(audio.getRepeatMode());
  }

  TrackEntity? get nextArtist {
    return nextIndex != null ? tracks[nextIndex!] : null;
  }

  TrackEntity? get previousArtist {
    return previousIndex != null ? tracks[previousIndex!] : null;
  }

  ConcatenatingAudioSource get playlist => _playlist;

  Future<void> next() async => await seekToNext();

  Future<void> previous() async => await seekToPrevious();

  Future<void> seekToIndex(int index) async {
    await seek(
      Duration.zero,
      index: index,
    );
  }

  Directory? tmpDir;

  Future<Duration?> playlistAddAll(
    List<TrackEntity> tracks, [
    int? index,
  ]) async {
    tmpDir ??= await getTemporaryDirectory();
    final children = <AudioSource>[];

    for (final track in tracks) {
      String artworkUrl = '${tmpDir!.path}/${track.id}.png';

      final mediaItem = MediaItem(
        id: track.hashCode.toString(),
        title: track.title,
        album: track.album,
        artist: track.artist,
        artUri: track.artwork != null ? Uri.parse('file://$artworkUrl') : null,
      );

      children.add(AudioSource.uri(track.uri, tag: mediaItem));
    }

    this.tracks = tracks;

    _playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: children,
    );

    GetIt.I.get<AudioRepository>().setTracksList(tracks);
    final result = await setAudioSource(_playlist, initialIndex: index);

    return result;
  }

  Future<void> playlistClear() async {
    await _playlist.clear();
    tracks.clear();
  }

  Future<void> setShuffleMode(bool enabled) async {
    GetIt.I.get<AudioRepository>().setShuffleMode(enabled);
    await setShuffleModeEnabled(enabled);
  }

  Future<void> setRepeatMode(AudioRepeatMode mode) async {
    GetIt.I.get<AudioRepository>().setRepeatMode(mode);
    LoopMode loop = LoopMode.off;

    switch (mode) {
      case AudioRepeatMode.all:
        loop = LoopMode.all;
        break;
      case AudioRepeatMode.one:
        loop = LoopMode.one;
        break;
      default:
        loop = LoopMode.off;
    }

    await setLoopMode(loop);
  }

  bool get showMiniplayer {
    return playerState.processingState == ProcessingState.ready;
  }
}
