part of 'home_cubit.dart';

@immutable
class HomeState {
  final PageController controller;
  final int index;

  const HomeState(
    this.controller, [
    this.index = 0,
  ]);
}
