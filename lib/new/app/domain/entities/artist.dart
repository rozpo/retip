import 'package:objectbox/objectbox.dart';

@Entity()
class Artist {
  @Id()
  int id;

  String name;

  Artist({
    this.id = 0,
    required this.name,
  });
}
