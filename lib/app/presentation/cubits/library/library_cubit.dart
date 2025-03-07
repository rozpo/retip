import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repositories/library_repository.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final LibraryRepository _libraryRepository;

  LibraryCubit({
    required LibraryRepository libraryRepository,
  })  : _libraryRepository = libraryRepository,
        super(LibraryInitial()) {
    scanLibrary();
  }

  Future<void> scanLibrary() async {
    emit(LibraryScanning());
    await _libraryRepository.scan();
    emit(LibraryScanned());
  }
}
