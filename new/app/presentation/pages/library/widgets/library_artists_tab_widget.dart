import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/retip_routes.dart';
import '../../../blocs/library/library_bloc.dart';

class LibraryArtistsTabWidget extends StatelessWidget {
  const LibraryArtistsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        if (state is LibraryLoadedState) {
          final artists = state.artists;

          return ListView.builder(
            itemCount: artists.length,
            itemBuilder: (context, index) {
              final album = artists[index];

              return ListTile(
                title: Text(album.name),
                onTap: () => context.pushNamed(
                  RetipRoutes.artist,
                  pathParameters: {
                    'id': album.artistId.toString(),
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
