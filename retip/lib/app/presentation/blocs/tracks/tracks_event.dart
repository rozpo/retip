part of 'tracks_bloc.dart';

@immutable
sealed class TracksEvent {
  const TracksEvent();

  @override
  String toString() {
    return runtimeType.toString();
  }
}

final class TracksScanEvent extends TracksEvent {
  const TracksScanEvent();
}

final class TracksRefreshEvent extends TracksEvent {
  final List<TrackEntity> tracks;

  const TracksRefreshEvent(this.tracks);

  @override
  String toString() {
    return '$runtimeType: tracks: ${tracks.length}';
  }
}
