import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/retip_routes.dart';
import '../../../blocs/library/library_bloc.dart';
import '../../../widgets/list_tiles/genre_list_tile_widget.dart';

class LibraryGenresTabWidget extends StatelessWidget {
  const LibraryGenresTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        if (state is LibraryLoadedState) {
          final genres = state.genres;

          return ListView.builder(
            itemCount: genres.length,
            itemBuilder: (context, index) {
              final genre = genres[index];

              return GenreListTileWidget(
                genre: genre,
                onTap: () => context.pushNamed(
                  RetipRoutes.genre,
                  pathParameters: {
                    'id': genre.genreId.toString(),
                  },
                ),
              );
            },
          );
        } else {
          return Center(
            child: FilledButton(
              onPressed: () {
                context.read<LibraryBloc>().add(const LibraryScanEvent());
              },
              child: const Text('Scan Library'),
            ),
          );
        }
      },
    );
  }
}
