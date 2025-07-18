import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/router/retip_routes.dart';
import '../../../../domain/services/playlist_service.dart';
import '../../../blocs/library/library_bloc.dart';
import '../../../widgets/list_tiles/playlist_list_tile_widget.dart';

class LibraryPlaylistsTabWidget extends StatelessWidget {
  const LibraryPlaylistsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PlaylistService>().create(const Uuid().v4());
        },
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

                return PlaylistListTileWidget(
                  playlist: playlist,
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
