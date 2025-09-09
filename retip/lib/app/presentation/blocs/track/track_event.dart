part of 'track_bloc.dart';

@immutable
sealed class TrackEvent {
  const TrackEvent();
}

final class TrackFetchAllEvent extends TrackEvent {
  const TrackFetchAllEvent();
}

final class TrackFetchByAlbumEvent extends TrackEvent {
  final int id;

  const TrackFetchByAlbumEvent(this.id);
}
