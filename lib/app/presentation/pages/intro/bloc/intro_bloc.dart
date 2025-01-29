import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/data/providers/file_provider.dart';
import 'package:retip/app/domain/repositories/library_repository.dart';

import '../../../../domain/repositories/permission_repository.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  final PermissionRepository _permissionRepository;
  final LibraryRepository _libraryRepository;

  IntroBloc({
    required PermissionRepository permissionRepository,
    required LibraryRepository libraryRepository,
  })  : _permissionRepository = permissionRepository,
        _libraryRepository = libraryRepository,
        super(IntroIdle()) {
    on<IntroCheckPermissionsEvent>(_checkPermissions);
    on<IntroAskPermissionsEvent>(_askPermissions);
    on<IntroLibraryScanEvent>(_onLibraryScan);
  }

  void _checkPermissions(
    IntroCheckPermissionsEvent event,
    Emitter<IntroState> emit,
  ) async {
    emit(IntroCheckingPermissions());

    if (await _permissionRepository.storagePermissionStatus()) {
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

    if (await _permissionRepository.storagePermissionStatus() ||
        await _permissionRepository.storagePermissionRequest()) {
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

    final tracks = await _libraryRepository.getAllTracks();
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
