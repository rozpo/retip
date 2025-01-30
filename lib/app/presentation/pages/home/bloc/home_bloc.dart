import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/domain/cases/get_all_tracks.dart';
import 'package:retip/app/domain/entities/track_entity.dart';

import '../../../../domain/repositories/audio_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

enum SortType {
  title,
  album,
  artist,
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AudioRepository _audioRepository;

  HomeBloc({
    required AudioRepository audioRepository,
  })  : _audioRepository = audioRepository,
        super(HomeInitState()) {
    on<HomeGetTracksEvent>(load);
    on<HomeSortTracksEvent>(sort);
    on<HomePlayTrackEvent>(play);
  }

  Future<void> load(HomeGetTracksEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitState());

    final tracks = await GetAllTracks.call();
    _audioRepository.setPlaylist(tracks);

    emit(HomeIdleState(tracks));
  }

  Future<void> sort(HomeSortTracksEvent event, Emitter<HomeState> emit) async {
    if (state is HomeIdleState == false) {
      return;
    }

    final sortType = (state as HomeIdleState).sortType;
    final tracks = (state as HomeIdleState).tracks;

    emit(HomeSortingState());

    final index = SortType.values.indexOf(sortType) + 1;

    final nextIndex = index >= SortType.values.length ? 0 : index;
    final nextSortType = SortType.values[nextIndex];

    switch (nextSortType) {
      case SortType.title:
        tracks.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortType.album:
        tracks.sort((a, b) {
          int result = a.album.compareTo(b.album);

          if (result == 0) {
            result = a.title.compareTo(b.title);
          }

          return result;
        });
        break;
      case SortType.artist:
        tracks.sort((a, b) {
          int result = a.artist.compareTo(b.artist);

          if (result == 0) {
            result = a.album.compareTo(b.album);
          }

          if (result == 0) {
            result = a.title.compareTo(b.title);
          }

          return result;
        });
        break;
    }

    _audioRepository.setPlaylist(tracks);

    emit(HomeIdleState(tracks, nextSortType));
  }

  Future<void> play(HomePlayTrackEvent event, Emitter<HomeState> emit) async {
    if (state is HomeIdleState == false) {
      return;
    }

    final tracks = (state as HomeIdleState).tracks;
    await _audioRepository.skipToIndex(event.index);
    _audioRepository.play();

    emit(HomeIdleState(tracks));
  }
}
