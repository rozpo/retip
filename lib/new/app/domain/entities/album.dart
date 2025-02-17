import 'package:objectbox/objectbox.dart';

@Entity()
class Album {
  @Id()
  int id;

  String artist;
  String title;

  Album({
    this.id = 0,
    required this.artist,
    required this.title,
  });
}
