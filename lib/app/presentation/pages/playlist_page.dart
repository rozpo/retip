import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/playlist_repository.dart';

class PlaylistPage extends StatelessWidget {
  final int playlistId;

  const PlaylistPage(
    this.playlistId, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final repository = context.read<PlaylistRepository>();

    return StreamBuilder(
      stream: repository.read(playlistId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final playlist = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(playlist.name),
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
            body: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: playlist.tracks.length,
              itemBuilder: (context, index) {
                final track = playlist.tracks[index];

                return ListTile(
                  onTap: () => repository.removeTrack(playlistId, track.id),
                  leading: Container(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.music_note),
                  ),
                  title: Text(track.title),
                  subtitle:
                      track.artist != null ? Text(track.artist!.name) : null,
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
