import 'package:flutter/material.dart';

class PlaylistPage extends StatelessWidget {
  final int id;

  const PlaylistPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist $id'),
      ),
    );
  }
}
