abstract class TrackEntity {
  final int id;

  final int trackId;
  final int albumId;
  final int artistId;
  final String title;
  final String album;
  final String artist;

  const TrackEntity({
    required this.id,
    required this.trackId,
    required this.albumId,
    required this.artistId,
    required this.title,
    required this.album,
    required this.artist,
  });
}
