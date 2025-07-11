import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/core/router/retip_routes.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.surfaceBright,
      child: ListTile(
        leading: IconButton.filled(
          color: Colors.black,
          onPressed: () {},
          icon: Icon(Icons.music_note),
        ),
        title: Text('My song title'),
        subtitle: Text('Awesome artist'),
        trailing: IconButton.filled(
          color: Colors.black,
          onPressed: () {},
          icon: Icon(Icons.pause),
        ),
        onTap: () => context.push(RetipRoutes.player),
      ),
    );
  }
}
