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
          return ListView.builder(
            itemCount: state.playlists.length,
            itemBuilder: (context, index) {
              final playlist = state.playlists[index];

              return ListTile(
                leading: const Icon(Icons.playlist_play),
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
          );
        }

        return const SizedBox();
      },
    );
  }
}
