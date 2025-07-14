part of 'library_bloc.dart';

@immutable
sealed class LibraryEvent {
  const LibraryEvent();
}

final class LibraryRefreshTracksEvent extends LibraryEvent {
  final List<TrackEntity> tracks;

  const LibraryRefreshTracksEvent(this.tracks);
}
