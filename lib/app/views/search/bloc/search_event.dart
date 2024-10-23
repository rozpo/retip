part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchRefreshEvent extends SearchEvent {
  final String text;

  SearchRefreshEvent(this.text);
}
