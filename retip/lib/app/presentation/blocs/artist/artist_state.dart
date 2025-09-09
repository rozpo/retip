part of 'artist_bloc.dart';

@immutable
sealed class ArtistState {
  const ArtistState();
}

final class ArtistIdleState extends ArtistState {
  final List<ArtistEntity> artists;

  const ArtistIdleState([this.artists = const []]);
}

final class AlbumErrorState extends ArtistState {
  final Exception error;

  const AlbumErrorState(this.error);
}
