part of 'artist_bloc.dart';

@immutable
sealed class ArtistEvent {
  const ArtistEvent();
}

final class ArtistRefreshEvent extends ArtistEvent {
  final List<ArtistEntity> artists;

  const ArtistRefreshEvent(this.artists);
}
