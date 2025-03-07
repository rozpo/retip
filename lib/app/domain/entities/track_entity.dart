abstract class TrackEntity {
  final int id;
  final String title;
  final String artist;
  final String location;
  final bool isFavorite;

  const TrackEntity({
    required this.id,
    required this.title,
    required this.artist,
    required this.location,
    required this.isFavorite,
  });
}
