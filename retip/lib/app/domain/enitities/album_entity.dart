abstract class AlbumEntity {
  final int artistId;
  final int albumId;

  final String title;
  final String artist;

  const AlbumEntity({
    required this.artistId,
    required this.albumId,
    required this.artist,
    required this.title,
  });
}
