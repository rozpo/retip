abstract class TrackEntity {
  final int id;
  final int trackId;
  final String title;
  final String album;
  final String artist;

  const TrackEntity({
    required this.id,
    required this.trackId,
    required this.title,
    required this.album,
    required this.artist,
  });
}
