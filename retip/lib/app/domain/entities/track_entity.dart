abstract class TrackEntity {
  final int id;
  final int trackId;

  final String title;
  final String artist;

  const TrackEntity({
    required this.id,
    required this.trackId,
    required this.title,
    required this.artist,
  });
}
