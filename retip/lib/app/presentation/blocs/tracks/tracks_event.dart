part of 'tracks_bloc.dart';

@immutable
sealed class TracksEvent {
  const TracksEvent();
}

final class TracksScanEvent extends TracksEvent {
  const TracksScanEvent();
}

final class TracksRefreshEvent extends TracksEvent {
  final List<TrackEntity> tracks;

  const TracksRefreshEvent(this.tracks);
}
