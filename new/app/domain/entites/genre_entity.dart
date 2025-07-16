abstract class GenreEntity {
  final int id;
  final int genreId;

  final String name;

  const GenreEntity({
    required this.id,
    required this.genreId,
    required this.name,
  });
}
