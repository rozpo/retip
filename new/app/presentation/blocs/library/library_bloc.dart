import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entites/album_entity.dart';
import '../../../domain/entites/artist_entity.dart';
import '../../../domain/entites/genre_entity.dart';
import '../../../domain/entites/playlist_entity.dart';
import '../../../domain/entites/track_entity.dart';
import '../../../domain/services/library_service.dart';
import '../../../domain/services/permissions_service.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final PermissionsService _permissionsService;
  final LibraryService _libraryService;

  LibraryBloc({
    required PermissionsService permissionsService,
    required LibraryService libraryService,
  })  : _permissionsService = permissionsService,
        _libraryService = libraryService,
        super(const LibraryIdleState()) {
    on<LibraryScanEvent>(_onScanTracks);
    on<LibraryRefreshPlaylistsEvent>(_onRefreshPlaylists);
    on<LibraryRefreshArtistsEvent>(_onRefreshArtists);
    on<LibraryRefreshAlbumsEvent>(_onRefreshAlbums);
    on<LibraryRefreshGenresEvent>(_onRefreshGenres);
    on<LibraryRefreshTracksEvent>(_onRefreshTracks);

    add(const LibraryScanEvent());
  }

  StreamSubscription? _playlistsStream;
  StreamSubscription? _artistsStream;
  StreamSubscription? _albumsStream;
  StreamSubscription? _genresStream;
  StreamSubscription? _tracksStream;

  @override
  Future<void> close() {
    _playlistsStream?.cancel();
    _artistsStream?.cancel();
    _albumsStream?.cancel();
    _genresStream?.cancel();
    _tracksStream?.cancel();

    return super.close();
  }

  void _onScanTracks(
    LibraryScanEvent event,
    Emitter<LibraryState> emit,
  ) async {
    final isGranted = await _permissionsService.checkMediaPermissions();

    if (isGranted) {
      _libraryService.scan();

      _genresStream ??= _libraryService.watchGenres().listen((genres) {
        add(LibraryRefreshGenresEvent(genres));
      });

      _artistsStream ??= _libraryService.watchArtists().listen((artists) {
        add(LibraryRefreshArtistsEvent(artists));
      });

      _albumsStream ??= _libraryService.watchAlbums().listen((albums) {
        add(LibraryRefreshAlbumsEvent(albums));
      });

      _tracksStream ??= _libraryService.watchTracks().listen((tracks) {
        add(LibraryRefreshTracksEvent(tracks));
      });

      emit(const LibraryLoadedState());
    }
  }

  void _onRefreshPlaylists(
    LibraryRefreshPlaylistsEvent event,
    Emitter<LibraryState> emit,
  ) {
    if (state is! LibraryLoadedState) return;
    final loadedState = state as LibraryLoadedState;

    final newState = loadedState.copyWith(playlists: event.playlists);
    emit(newState);
  }

  void _onRefreshGenres(
    LibraryRefreshGenresEvent event,
    Emitter<LibraryState> emit,
  ) {
    if (state is! LibraryLoadedState) return;
    final loadedState = state as LibraryLoadedState;

    final newState = loadedState.copyWith(genres: event.genres);
    emit(newState);
  }

  void _onRefreshArtists(
    LibraryRefreshArtistsEvent event,
    Emitter<LibraryState> emit,
  ) {
    if (state is! LibraryLoadedState) return;
    final loadedState = state as LibraryLoadedState;

    final newState = loadedState.copyWith(artists: event.artists);
    emit(newState);
  }

  void _onRefreshAlbums(
    LibraryRefreshAlbumsEvent event,
    Emitter<LibraryState> emit,
  ) {
    if (state is! LibraryLoadedState) return;
    final loadedState = state as LibraryLoadedState;

    final newState = loadedState.copyWith(albums: event.albums);
    emit(newState);
  }

  void _onRefreshTracks(
    LibraryRefreshTracksEvent event,
    Emitter<LibraryState> emit,
  ) {
    if (state is! LibraryLoadedState) return;
    final loadedState = state as LibraryLoadedState;

    final newState = loadedState.copyWith(tracks: event.tracks);
    emit(newState);
  }
}
