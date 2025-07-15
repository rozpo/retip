part of 'library_bloc.dart';

@immutable
sealed class LibraryEvent {
  const LibraryEvent();
}

final class LibraryScanEvent extends LibraryEvent {
  const LibraryScanEvent();
}

final class LibraryRefreshArtistsEvent extends LibraryEvent {
  final List<ArtistEntity> artists;

  const LibraryRefreshArtistsEvent(this.artists);
}

final class LibraryRefreshAlbumsEvent extends LibraryEvent {
  final List<AlbumEntity> albums;

  const LibraryRefreshAlbumsEvent(this.albums);
}

final class LibraryRefreshTracksEvent extends LibraryEvent {
  final List<TrackEntity> tracks;

  const LibraryRefreshTracksEvent(this.tracks);
}
