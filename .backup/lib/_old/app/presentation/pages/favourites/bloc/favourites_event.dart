part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesEvent {}

final class GetFavouritesEvent extends FavouritesEvent {}

final class AddToFavouritesEvent extends FavouritesEvent {}

final class RemoveFromFavouritesEvent extends FavouritesEvent {}

final class UpdateTitleEvent extends FavouritesEvent {
  final String? title;

  UpdateTitleEvent([this.title]);
}
