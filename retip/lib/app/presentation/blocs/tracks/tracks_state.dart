part of 'tracks_bloc.dart';

@immutable
final class TracksState {
  final List<TrackEntity> tracks;

  const TracksState(this.tracks);

  @override
  String toString() {
    return '$runtimeType: tracks: ${tracks.length}';
  }
}
