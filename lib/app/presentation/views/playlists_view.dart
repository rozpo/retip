import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/playlist/playlist_bloc.dart';

class PlaylistsView extends StatelessWidget {
  const PlaylistsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PlaylistBloc>();

    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
        if (state is PlaylistInitial) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => bloc.add(PlaylistCreate()),
              child: const Icon(Icons.add),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.playlists.length,
              itemBuilder: (context, index) {
                final playlist = state.playlists[index];

                return ListTile(
                  leading: Container(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.playlist_add),
                  ),
                  title: Text(
                    playlist.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    playlist.tracks.length.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onLongPress: () {
                    bloc.add(PlaylistRemove(playlist.id));
                  },
                  trailing: IconButton(
                    onPressed: () {
                      bloc.add(PlaylistToggleFavorite(playlist));
                    },
                    icon: Icon(
                      playlist.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_outline_outlined,
                    ),
                  ),
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
