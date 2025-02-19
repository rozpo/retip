abstract class AlbumEntity {
  final int id;

  final String title;
  final String artist;

  final String? artwork;

  AlbumEntity({
    required this.id,
    required this.title,
    required this.artist,
    this.artwork,
  });
}
