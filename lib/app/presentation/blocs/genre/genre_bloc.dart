import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/genre_entity.dart';
import '../../../domain/repositories/genre_repository.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final GenreRepository _genreRepository;

  GenreBloc({
    required GenreRepository genreRepository,
  })  : _genreRepository = genreRepository,
        super(GenreInitial(const [])) {
    on<GenreRefresh>(_onGenreRefresh);
    on<GenreToggleFavorite>(_onGenreToggleFavorite);

    _subscription = _genreRepository.stream().listen((genres) {
      add(GenreRefresh(genres));
    });
  }

  StreamSubscription? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void _onGenreRefresh(GenreRefresh event, Emitter<GenreState> emit) {
    emit(GenreInitial(event.genres));
  }

  void _onGenreToggleFavorite(
      GenreToggleFavorite event, Emitter<GenreState> emit) {
    _genreRepository.toggleFavorite(event.genre);
  }
}
