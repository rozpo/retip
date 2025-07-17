import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/retip_routes.dart';
import '../../../blocs/library/library_bloc.dart';
import '../../../widgets/list_tiles/album_list_tile_widget.dart';

class LibraryAlbumsTabWidget extends StatelessWidget {
  const LibraryAlbumsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        if (state is LibraryLoadedState) {
          final albums = state.albums;

          return ListView.builder(
            itemCount: albums.length,
            itemBuilder: (context, index) {
              final album = albums[index];

              return AlbumListTileWidget(
                album: album,
                onTap: () => context.pushNamed(
                  RetipRoutes.album,
                  pathParameters: {
                    'id': album.albumId.toString(),
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
