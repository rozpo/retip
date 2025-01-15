import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/data/providers/file_provider.dart';
import 'package:retip/app/data/providers/retip_permission.dart';
import 'package:retip/app/domain/repositories/library_repository.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  IntroBloc() : super(IntroIdle()) {
    on<IntroCheckPermissionsEvent>(_checkPermissions);
    on<IntroAskPermissionsEvent>(_askPermissions);
    on<IntroLibraryScanEvent>(_onLibraryScan);
  }

  void _checkPermissions(
    IntroCheckPermissionsEvent event,
    Emitter<IntroState> emit,
  ) async {
    emit(IntroCheckingPermissions());

    if (await RetipPermission.check()) {
      emit(IntroPermissionsGranted());
    } else {
      emit(IntroIdle());
    }
  }

  void _askPermissions(
    IntroAskPermissionsEvent event,
    Emitter<IntroState> emit,
  ) async {
    emit(IntroCheckingPermissions());

    if (await RetipPermission.checkAndRequest()) {
      emit(IntroPermissionsGranted());
    } else {
      emit(IntroIdle());
    }
  }

  void _onLibraryScan(
    IntroLibraryScanEvent event,
    Emitter<IntroState> emit,
  ) async {
    emit(const IntroLibraryScanning(progress: 0.0));

    final repo = GetIt.I.get<LibraryRepository>();

    final tracks = await repo.getAllTracks();
    final provider = FileProvider();

    for (var i = 0; i < tracks.length; i++) {
      final track = tracks[i];

      if (track.artwork != null && track.albumId != null) {
        await provider.writeFile('album_${track.albumId}', track.artwork!);
      }

      emit(IntroLibraryScanning(
          progress: i / tracks.length, filename: track.fileLocation));
    }

    emit(IntroLibraryScanned());
  }
}
