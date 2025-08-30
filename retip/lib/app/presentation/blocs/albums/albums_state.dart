part of 'albums_bloc.dart';

@immutable
final class AlbumsState {
  final List<AlbumEntity> albums;

  const AlbumsState(this.albums);

  @override
  String toString() {
    return '$runtimeType: albums: ${albums.length}';
  }
}
