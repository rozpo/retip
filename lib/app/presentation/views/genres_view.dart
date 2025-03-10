import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/genre/genre_bloc.dart';

class GenresView extends StatelessWidget {
  const GenresView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GenreBloc>();

    return BlocBuilder<GenreBloc, GenreState>(
      builder: (context, state) {
        if (state is GenreInitial) {
          return ListView.builder(
            itemCount: state.genres.length,
            itemBuilder: (context, index) {
              final genre = state.genres[index];
              return ListTile(
                leading: Container(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.category),
                ),
                title: Text(genre.name),
                subtitle: Text(genre.tracks.length.toString()),
                trailing: IconButton(
                  style: Theme.of(context).iconButtonTheme.style,
                  icon: Icon(
                    genre.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: () {
                    bloc.add(GenreToggleFavorite(genre));
                  },
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
