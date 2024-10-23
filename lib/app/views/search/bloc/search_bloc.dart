import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/data/repositories/on_audio_query_artist_repository.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/services/entities/track_entity.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchIdleState()) {
    on<SearchRefreshEvent>(_search);
  }

  void _search(
    SearchRefreshEvent event,
    Emitter<SearchState> emit,
  ) async {
    // Nothing to search, back to init state
    if (event.text.isEmpty) {
      emit(SearchIdleState());
      return;
    }

    // Indicate the searching logic was invoked
    emit(SearchSearchingState());

    final data = await OnAudioQueryArtistRepository().getAll();
    final artists = <ArtistEntity>[];
    final albums = <AlbumEntity>[];
    final tracks = <TrackEntity>[];

    final query = event.text.toLowerCase();

    for (final artist in data) {
      if (artist.name.toLowerCase().contains(query)) {
        artists.add(artist);
      }

      for (final album in artist.albums) {
        if (album.title.toLowerCase().contains(query)) {
          albums.add(album);
        }

        for (final track in album.tracks) {
          if (track.title.toLowerCase().contains(query)) {
            tracks.add(track);
          }
        }
      }
    }

    if (artists.isEmpty && albums.isEmpty && tracks.isEmpty) {
      // No data found, change to error state
      emit(SearchErrorState());
    } else {
      // Return data
      emit(SearchSuccessState(
        artists: artists,
        albums: albums,
        tracks: tracks,
      ));
    }
  }
}
