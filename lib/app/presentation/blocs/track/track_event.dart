part of 'track_bloc.dart';

@immutable
sealed class TrackEvent {}

final class TrackRefresh extends TrackEvent {
  final List<TrackEntity> tracks;

  TrackRefresh(this.tracks);
}

final class TrackToggleFavorite extends TrackEvent {
  final TrackEntity track;

  TrackToggleFavorite(this.track);
}
