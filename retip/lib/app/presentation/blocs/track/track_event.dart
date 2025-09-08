part of 'track_bloc.dart';

@immutable
sealed class TrackEvent {
  const TrackEvent();
}

final class TrackRefreshEvent extends TrackEvent {
  final List<TrackEntity> tracks;

  const TrackRefreshEvent(this.tracks);
}
