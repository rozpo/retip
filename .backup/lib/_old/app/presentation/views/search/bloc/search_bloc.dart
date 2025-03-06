import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../data/providers/shared_preferences_provider.dart';
import '../../../../domain/cases/get_all_artists.dart';
import '../../../../domain/cases/playlist/get_all_playlists.dart';
import '../../../../domain/entities/abstract_entity.dart';
import '../../../../domain/entities/album_entity.dart';
import '../../../../domain/entities/artist_entity.dart';
import '../../../../domain/entities/playlist_entity.dart';
import '../../../../domain/entities/track_entity.dart';

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

      artists.sort((a, b) {
        return a.name.indexOf(query).compareTo(b.name.indexOf(query));
      });

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

      albums.sort((a, b) {
        return a.title.indexOf(query).compareTo(b.title.indexOf(query));
      });

      tracks.sort((a, b) {
        return a.title.indexOf(query).compareTo(b.title.indexOf(query));
      });
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
