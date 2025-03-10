part of 'genre_bloc.dart';

@immutable
sealed class GenreEvent {}

class GenreRefresh extends GenreEvent {
  final List<GenreEntity> genres;

  GenreRefresh(this.genres);
}

class GenreToggleFavorite extends GenreEvent {
  final GenreEntity genre;

  GenreToggleFavorite(this.genre);
}
