import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retip/app/domain/enitities/artist_entity.dart';
import 'package:retip/app/domain/errors/result.dart';
import 'package:retip/app/domain/repositories/artist_repository.dart';

part 'artist_event.dart';
part 'artist_state.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  final ArtistRepository _artistRepository;

  ArtistBloc(this._artistRepository) : super(ArtistIdleState()) {
    on<ArtistRefreshEvent>(_onRefresh);

    _artistRepository.getAll().then((result) {
      if (result is ResultSuccess<List<ArtistEntity>>) {
        add(ArtistRefreshEvent(result.data));
      }
    });
  }

  void _onRefresh(ArtistRefreshEvent event, Emitter<ArtistState> emit) {
    emit(ArtistIdleState(event.artists));
  }
}
