import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
    on<LibraryRefreshTracksEvent>(_onRefreshTracks);

    add(const LibraryScanEvent());
  }

  Stream? _tracksStream;

  void _onScanTracks(
    LibraryScanEvent event,
    Emitter<LibraryState> emit,
  ) async {
    final isGranted = await _permissionsService.checkMediaPermissions();

    if (isGranted) {
      _libraryService.scan();

      _tracksStream ??= _libraryService.watchTracks();

      _tracksStream!.listen((tracks) {
        add(LibraryRefreshTracksEvent(tracks));
      });
    }
  }

  void _onRefreshTracks(
    LibraryRefreshTracksEvent event,
    Emitter<LibraryState> emit,
  ) {
    final newState = LibraryLoadedState(tracks: event.tracks);
    emit(newState);
  }
}
