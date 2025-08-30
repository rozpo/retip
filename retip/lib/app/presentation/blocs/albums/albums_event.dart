part of 'albums_bloc.dart';

@immutable
sealed class AlbumsEvent {
  const AlbumsEvent();

  @override
  String toString() {
    return runtimeType.toString();
  }
}

final class AlbumsScanEvent extends AlbumsEvent {
  const AlbumsScanEvent();
}

final class AlbumsRefreshEvent extends AlbumsEvent {
  final List<AlbumEntity> albums;

  const AlbumsRefreshEvent(this.albums);

  @override
  String toString() {
    return '$runtimeType: albums: ${albums.length}';
  }
}
