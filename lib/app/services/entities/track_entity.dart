abstract class TrackEntity {
  final String title;
  final String album;
  final String artist;
  final Uri uri;

  TrackEntity({
    required this.title,
    required this.album,
    required this.artist,
    required this.uri,
  });
}
