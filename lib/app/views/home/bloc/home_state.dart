part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitState extends HomeState {}

final class HomeSortingState extends HomeState {}

final class HomeIdleState extends HomeState {
  final List<TrackEntity> tracks;
  final SortType sortType;

  HomeIdleState(this.tracks, [this.sortType = SortType.title]);
}
