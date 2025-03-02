part of 'tracks_bloc.dart';

@immutable
sealed class TracksEvent {
  const TracksEvent();
}

class FetchTracksEvent extends TracksEvent {}

class SortTracksEvent extends TracksEvent {
  final List<TrackEntity>? tracks;
  final SortType sortType;

  const SortTracksEvent({
    this.sortType = SortType.title,
    this.tracks,
  });
}

class PlayTracksEvent extends TracksEvent {
  final int index;

  const PlayTracksEvent({
    this.index = 0,
  });
}
