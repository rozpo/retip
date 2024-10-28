import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/services/cases/get_all_tracks.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/core/audio/retip_audio.dart';

part 'home_event.dart';
part 'home_state.dart';

enum SortType {
  title,
  album,
  artist,
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitState()) {
    on<HomeGetTracksEvent>(load);
    on<HomeSortTracksEvent>(sort);
    on<HomePlayTrackEvent>(play);
  }

  Future<void> load(HomeGetTracksEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitState());

    final tracks = await GetAllTracks.call();
    final audio = GetIt.instance.get<RetipAudio>();

    audio.playlistAddAll(tracks);

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

    final audio = GetIt.instance.get<RetipAudio>();

    audio.playlistAddAll(tracks);

    emit(HomeIdleState(tracks, nextSortType));
  }

  Future<void> play(HomePlayTrackEvent event, Emitter<HomeState> emit) async {
    if (state is HomeIdleState == false) {
      return;
    }

    final tracks = (state as HomeIdleState).tracks;
    final audio = GetIt.instance.get<RetipAudio>();

    await audio.stop();
    await audio.seekToIndex(event.index);
    await audio.play();

    emit(HomeIdleState(tracks));
  }
}
