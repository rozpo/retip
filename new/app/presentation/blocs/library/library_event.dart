part of 'library_bloc.dart';

@immutable
sealed class LibraryEvent {
  const LibraryEvent();
}

final class LibraryScanEvent extends LibraryEvent {
  const LibraryScanEvent();
}

final class LibraryRefreshTracksEvent extends LibraryEvent {
  final List<TrackEntity> tracks;

  const LibraryRefreshTracksEvent(this.tracks);
}
