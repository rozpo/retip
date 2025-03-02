abstract class Track {
  final int id;
  final String artist;
  final String album;
  final String title;
  final String location;
  final String? artwork;

  Track({
    required this.id,
    required this.artist,
    required this.album,
    required this.title,
    required this.location,
    required this.artwork,
  });
}
