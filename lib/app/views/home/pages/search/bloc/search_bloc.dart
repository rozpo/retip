import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/data/providers/shared_preferences_provider.dart';
import 'package:retip/app/services/cases/get_all_artists.dart';
import 'package:retip/app/services/cases/playlist/get_all_playlists.dart';
import 'package:retip/app/services/entities/abstract_entity.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/services/entities/playlist_entity.dart';
import 'package:retip/app/services/entities/track_entity.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final provider = GetIt.I.get<SharedPreferencesProvider>();

  final List<String> recentSearch = [];

  SearchBloc() : super(SearchIdleState()) {
    final data = provider.getStringList('recentSearch');

    if (data != null) {
      recentSearch.addAll(data);
    }

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

    final data = await GetAllArtists.call();
    final pls = await GetAllPlaylists.call();

    final artists = <ArtistEntity>[];
    final albums = <AlbumEntity>[];
    final playlists = <PlaylistEntity>[];
    final tracks = <TrackEntity>[];

    final query = event.text.toLowerCase();

    for (final artist in data) {
      if (artist.name.toLowerCase().contains(query)) {
        if (artist.albums.isNotEmpty) {
          artists.add(artist);
        }
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

    for (final pl in pls) {
      if (pl.name.toLowerCase().contains(query)) {
        playlists.add(pl);
      }
    }

    if (recentSearch.any((e) => e.toLowerCase() == event.text.toLowerCase()) ==
        false) {
      recentSearch.add(event.text);
    }

    if (recentSearch.length > 25) {
      recentSearch.removeAt(0);
    }

    provider.setStringList('recentSearch', recentSearch);

    if (artists.isEmpty && albums.isEmpty && tracks.isEmpty) {
      // No data found, change to error state
      emit(SearchErrorState());
    } else {
      // Return data
      emit(SearchSuccessState(
        artists: artists,
        albums: albums,
        playlists: playlists,
        tracks: tracks,
        query: event.text,
      ));
    }
  }
}
