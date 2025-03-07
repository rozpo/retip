part of 'track_bloc.dart';

@immutable
sealed class TrackState {}

final class TrackInitial extends TrackState {
  final List<TrackEntity> tracks;

  TrackInitial(this.tracks);
}
