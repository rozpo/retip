import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entites/album_entity.dart';
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
    on<LibraryRefreshAlbumsEvent>(_onRefreshAlbums);
    on<LibraryRefreshTracksEvent>(_onRefreshTracks);

    add(const LibraryScanEvent());
  }

  StreamSubscription? _albumsStream;
  StreamSubscription? _tracksStream;

  void _onScanTracks(
    LibraryScanEvent event,
    Emitter<LibraryState> emit,
  ) async {
    final isGranted = await _permissionsService.checkMediaPermissions();

    if (isGranted) {
      _libraryService.scan();

      _albumsStream ??= _libraryService.watchAlbums().listen((albums) {
        add(LibraryRefreshAlbumsEvent(albums));
      });

      _tracksStream ??= _libraryService.watchTracks().listen((tracks) {
        add(LibraryRefreshTracksEvent(tracks));
      });

      emit(const LibraryLoadedState());
    }
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
