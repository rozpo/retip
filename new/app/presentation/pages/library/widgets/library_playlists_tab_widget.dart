import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/retip_routes.dart';
import '../../../blocs/library/library_bloc.dart';

class LibraryPlaylistsTabWidget extends StatelessWidget {
  const LibraryPlaylistsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (context, state) {
          if (state is LibraryLoadedState) {
            final playlists = state.playlists;

            return ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];

                return ListTile(
                  title: Text(playlist.name),
                  onTap: () => context.pushNamed(
                    RetipRoutes.playlist,
                    pathParameters: {
                      'id': playlist.id.toString(),
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
      ),
    );
  }
}
