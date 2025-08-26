import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.music_note),
      title: Text('Song Title'),
      subtitle: Text('Artist Name'),
      onTap: () {
        context.push('/player');
      },
      trailing: IconButton(icon: Icon(Icons.play_arrow), onPressed: () {}),
    );
  }
}
