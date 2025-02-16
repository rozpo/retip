import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../domain/cases/favourites/get_all_favourites.dart';
import '../../../../domain/entities/track_entity.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final scrollController = ScrollController();
  final titleKey = GlobalKey();

  FavouritesBloc() : super(const FavouritesState()) {
    on<GetFavouritesEvent>(getFavourites);
    on<UpdateTitleEvent>(updateTitle);
  }

  void getFavourites(
    GetFavouritesEvent event,
    Emitter<FavouritesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final data = await GetAllFavourites.call('TrackModel');
    final tracks = List<TrackEntity>.from(data);

    if (tracks.isNotEmpty) {
      emit(state.copyWith(tracks: tracks, isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  void updateTitle(
    UpdateTitleEvent event,
    Emitter<FavouritesState> emit,
  ) {
    emit(state.copyWith(title: event.title ?? ''));
  }
}
