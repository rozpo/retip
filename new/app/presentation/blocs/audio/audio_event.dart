part of 'audio_bloc.dart';

@immutable
sealed class AudioEvent {
  const AudioEvent();
}

final class AudioLoadPlaylistEvent extends AudioEvent {
  final List<TrackEntity> tracks;
  final bool autoplay;
  final int? index;

  const AudioLoadPlaylistEvent(
    this.tracks, {
    this.autoplay = true,
    this.index,
  });
}

final class AudioPlayEvent extends AudioEvent {
  const AudioPlayEvent();
}
