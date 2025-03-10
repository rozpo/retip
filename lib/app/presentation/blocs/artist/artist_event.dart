part of 'artist_bloc.dart';

@immutable
sealed class ArtistEvent {}

class ArtistRefresh extends ArtistEvent {
  final List<ArtistEntity> artists;

  ArtistRefresh(this.artists);
}

class ArtistToggleFavorite extends ArtistEvent {
  final ArtistEntity artist;

  ArtistToggleFavorite(this.artist);
}
