part of 'audio_bloc.dart';

@immutable
sealed class AudioEvent {}

class AudioPlay extends AudioEvent {
  final List<TrackEntity> tracks;
  final int index;

  AudioPlay(this.tracks, this.index);
}

class AudioResume extends AudioEvent {}

class AudioPause extends AudioEvent {}

class AudioNext extends AudioEvent {}

class AudioPrevious extends AudioEvent {}

class AudioTrackChanged extends AudioEvent {
  final TrackEntity track;

  AudioTrackChanged(this.track);
}

class AudioIndexChanged extends AudioEvent {
  final int index;

  AudioIndexChanged(this.index);
}

class AudioIsPlayingChanged extends AudioEvent {
  final bool isPlaying;

  AudioIsPlayingChanged(this.isPlaying);
}

class AudioPositionChanged extends AudioEvent {
  final Duration position;

  AudioPositionChanged(this.position);
}

class AudioDurationChanged extends AudioEvent {
  final Duration duration;

  AudioDurationChanged(this.duration);
}
