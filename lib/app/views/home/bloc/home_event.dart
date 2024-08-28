part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeGetTracksEvent extends HomeEvent {}

final class HomeSortTracksEvent extends HomeEvent {}

final class HomePlayTrackEvent extends HomeEvent {
  final int index;

  HomePlayTrackEvent(this.index);
}
