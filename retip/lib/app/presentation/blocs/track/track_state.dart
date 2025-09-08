part of 'track_bloc.dart';

@immutable
sealed class TrackState {
  const TrackState();
}

final class TrackIdleState extends TrackState {
  final List<TrackEntity> tracks;

  const TrackIdleState([this.tracks = const []]);
}

final class TrackErrorState extends TrackState {
  final Exception error;

  const TrackErrorState(this.error);
}
