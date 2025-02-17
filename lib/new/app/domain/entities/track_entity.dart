abstract class TrackEntity {
  final int id;

  final String title;
  final String album;
  final String artist;

  final String location;

  TrackEntity({
    required this.id,
    required this.title,
    required this.album,
    required this.artist,
    required this.location,
  });
}
