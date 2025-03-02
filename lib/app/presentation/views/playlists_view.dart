import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_router.dart';

class PlaylistsView extends StatelessWidget {
  const PlaylistsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Playlist $index'),
          leading: const Icon(Icons.playlist_play),
          onTap: () => context.pushNamed(
            pathParameters: {'id': '$index'},
            RetipRouter.playlist,
          ),
        );
      },
    );
  }
}
