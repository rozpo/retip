part of 'audio_bloc.dart';

@immutable
class AudioState {
  final List<TrackEntity> playlist;
  final TrackEntity? currentTrack;

  final int index;
  final bool isPlaying;
  final Duration position;
  final Duration duration;

  const AudioState({
    required this.currentTrack,
    required this.playlist,
    required this.index,
    required this.isPlaying,
    required this.position,
    required this.duration,
  });

  factory AudioState.initial() {
    return const AudioState(
      currentTrack: null,
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
    TrackEntity? currentTrack,
  }) {
    return AudioState(
      currentTrack: currentTrack ?? this.currentTrack,
      playlist: playlist ?? this.playlist,
      index: index ?? this.index,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
    );
  }
}
