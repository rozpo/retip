import 'package:flutter/material.dart';

class PlaylistsView extends StatelessWidget {
  const PlaylistsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text(index.toString())),
          title: Text('Playlist $index'),
        );
      },
    );
  }
}
