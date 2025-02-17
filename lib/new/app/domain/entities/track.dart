import 'package:objectbox/objectbox.dart';

@Entity()
class Track {
  @Id()
  int id;

  String artist;
  String album;
  String title;

  @Unique()
  String location;

  Track({
    this.id = 0,
    required this.artist,
    required this.album,
    required this.title,
    required this.location,
  });
}
