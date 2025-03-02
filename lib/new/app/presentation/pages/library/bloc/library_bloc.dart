import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/usecases/library_usecase.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final LibraryUsecase _libraryUsecase;

  LibraryBloc({
    required LibraryUsecase libraryUsecase,
  })  : _libraryUsecase = libraryUsecase,
        super(LibraryInitial()) {
    _libraryUsecase.scan();
  }
}
