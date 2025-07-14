import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entites/track_entity.dart';
import '../../../domain/services/library_service.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final LibraryService _libraryService;

  LibraryBloc({
    required LibraryService libraryService,
  })  : _libraryService = libraryService,
        super(const LibraryState()) {
    on<LibraryRefreshTracksEvent>(_onRefreshTracks);

    _libraryService.scan();

    _tracksStream = _libraryService.watchTracks();

    _tracksStream.listen((tracks) {
      add(LibraryRefreshTracksEvent(tracks));
    });
  }

  late final Stream _tracksStream;

  void _onRefreshTracks(
    LibraryRefreshTracksEvent event,
    Emitter<LibraryState> emit,
  ) {
    final newState = state.copyWith(tracks: event.tracks);
    emit(newState);
  }
}
