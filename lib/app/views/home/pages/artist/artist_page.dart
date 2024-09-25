import 'package:flutter/material.dart';
import 'package:retip/app/services/entities/artist_entity.dart';

class ArtistPage extends StatelessWidget {
  final ArtistEntity artist;

  const ArtistPage({
    required this.artist,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artist.name),
      ),
    );
  }
}
