part of 'artist_bloc.dart';

@immutable
sealed class ArtistState {}

final class ArtistInitial extends ArtistState {
  final List<ArtistEntity> artists;

  ArtistInitial(this.artists);
}
