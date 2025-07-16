import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/retip_routes.dart';
import '../../../blocs/library/library_bloc.dart';

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
              final album = genres[index];

              return ListTile(
                title: Text(album.name),
                onTap: () => context.pushNamed(
                  RetipRoutes.genre,
                  pathParameters: {
                    'id': album.genreId.toString(),
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
