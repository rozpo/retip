import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_routes.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.push(RetipRoutes.player),
      tileColor: Theme.of(context).colorScheme.surfaceBright,
      title: const Text('My song name'),
      subtitle: const Text('Awesome artist'),
      leading: Container(
        width: 40,
        height: 40,
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: const Icon(Icons.music_note),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}
