import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/album/album_bloc.dart';

class AlbumsView extends StatelessWidget {
  const AlbumsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AlbumBloc>();

    return BlocBuilder<AlbumBloc, AlbumState>(
      builder: (context, state) {
        if (state is AlbumInitial) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: state.albums.length,
            itemBuilder: (context, index) {
              final album = state.albums[index];

              return ListTile(
                onTap: () => bloc.add(AlbumToggleFavorite(album)),
                leading: Container(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.album),
                ),
                title: Text(
                  album.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  album.artist?.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  style: Theme.of(context).iconButtonTheme.style,
                  onPressed: () => bloc.add(AlbumToggleFavorite(album)),
                  icon: Icon(
                    album.isFavorite ? Icons.favorite : Icons.favorite_border,
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
