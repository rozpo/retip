part of 'audio_bloc.dart';

@immutable
class AudioState {
  final List<TrackEntity> playlist;

  TrackEntity? get currentTrack {
    return (index < playlist.length) ? playlist[index] : null;
  }

  final int index;
  final bool isPlaying;
  final Duration position;
  final Duration duration;

  const AudioState({
    required this.playlist,
    required this.index,
    required this.isPlaying,
    required this.position,
    required this.duration,
  });

  factory AudioState.initial() {
    return const AudioState(
      playlist: [],
      position: Duration.zero,
      duration: Duration.zero,
      isPlaying: false,
      index: 0,
    );
  }

  AudioState copyWith({
    List<TrackEntity>? playlist,
    int? index,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
  }) {
    return AudioState(
      playlist: playlist ?? this.playlist,
      index: index ?? this.index,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
    );
  }
}
