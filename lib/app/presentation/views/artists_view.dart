import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/artist/artist_bloc.dart';

class ArtistsView extends StatelessWidget {
  const ArtistsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ArtistBloc>();

    return BlocBuilder<ArtistBloc, ArtistState>(
      builder: (context, state) {
        if (state is ArtistInitial) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: state.artists.length,
            itemBuilder: (context, index) {
              final artist = state.artists[index];

              return ListTile(
                onTap: () => bloc.add(ArtistToggleFavorite(artist)),
                leading: Container(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.person),
                ),
                title: Text(
                  artist.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  artist.albums.length.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  style: Theme.of(context).iconButtonTheme.style,
                  onPressed: () => bloc.add(ArtistToggleFavorite(artist)),
                  icon: Icon(
                    artist.isFavorite ? Icons.favorite : Icons.favorite_border,
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
