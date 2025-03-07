part of 'album_bloc.dart';

@immutable
sealed class AlbumState {}

final class AlbumInitial extends AlbumState {
  final List<AlbumEntity> albums;

  AlbumInitial(this.albums);
}
