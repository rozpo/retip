import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/artist_entity.dart';
import '../../../domain/repositories/artist_repository.dart';

part 'artist_event.dart';
part 'artist_state.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  final ArtistRepository _artistRepository;

  ArtistBloc({
    required ArtistRepository artistRepository,
  })  : _artistRepository = artistRepository,
        super(ArtistInitial(const [])) {
    on<ArtistRefresh>(_onArtistRefresh);
    on<ArtistToggleFavorite>(_onArtistToggleFavorite);

    _subscription = _artistRepository.stream().listen((artists) {
      add(ArtistRefresh(artists));
    });
  }

  StreamSubscription? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  void _onArtistRefresh(ArtistRefresh event, Emitter<ArtistState> emit) {
    emit(ArtistInitial(event.artists));
  }

  void _onArtistToggleFavorite(
      ArtistToggleFavorite event, Emitter<ArtistState> emit) {
    _artistRepository.toggleFavorite(event.artist);
  }
}
