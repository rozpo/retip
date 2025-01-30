import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:retip/app/data/providers/file_provider.dart';
import 'package:retip/app/domain/entities/track_entity.dart';
import 'package:retip/app/domain/repositories/audio_repository.dart';

class JustAudioProvider extends AudioPlayer {
  final ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(
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
      await setPlaylist(tracks);
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

  Future<void> setPlaylist(List<TrackEntity> tracks, [int index = 0]) async {
    final fileProvider = FileProvider();

    final children = <AudioSource>[];

    for (final track in tracks) {
      String? artworkUrl;

      if (track.artwork != null && track.albumId != null) {
        artworkUrl = await fileProvider.getFilePath('album_${track.albumId}');
      }

      final mediaItem = MediaItem(
        id: track.hashCode.toString(),
        title: track.title,
        album: track.album,
        artist: track.artist,
        artUri: artworkUrl != null ? Uri.parse('file://$artworkUrl') : null,
      );

      children.add(AudioSource.uri(track.uri, tag: mediaItem));
    }

    this.tracks.clear();
    this.tracks.addAll(tracks);

    playlist.clear();
    playlist.addAll(children);

    await setAudioSource(playlist, initialIndex: index);
  }
}
