abstract class AlbumEntity {
  final int id;
  final int albumId;
  final int artistId;

  final String title;
  final String artist;

  const AlbumEntity({
    required this.id,
    required this.albumId,
    required this.artistId,
    required this.title,
    required this.artist,
  });
}
