part of 'genre_bloc.dart';

@immutable
sealed class GenreState {}

final class GenreInitial extends GenreState {
  final List<GenreEntity> genres;

  GenreInitial(this.genres);
}
