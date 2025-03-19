import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_routes.dart';
import '../blocs/playlist/playlist_bloc.dart';
import '../widgets/molecules/list_tile_widget.dart';
import '../widgets/organisms/sheets/playlist_sheet_widget.dart';

class PlaylistsView extends StatelessWidget {
  final bool showFab;
  final void Function(int playlistId)? onTap;

  const PlaylistsView({
    this.showFab = true,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PlaylistBloc>();

    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
        if (state is PlaylistInitial) {
          return Scaffold(
            floatingActionButton: showFab
                ? FloatingActionButton(
                    onPressed: () => bloc.add(PlaylistCreate()),
                    child: const Icon(Icons.add),
                  )
                : null,
            body: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.playlists.length,
              itemBuilder: (context, index) {
                final playlist = state.playlists[index];

                return ListTileWidget(
                  onTap: onTap != null
                      ? () => onTap?.call(playlist.id)
                      : () {
                          context.pushNamed(
                            RetipRoutes.playlist,
                            pathParameters: {'id': playlist.id.toString()},
                          );
                        },
                  tileIcon: Icons.playlist_play,
                  title: playlist.name,
                  subtitle: playlist.tracks.length.toString(),
                  // onLongPress: () => bloc.add(PlaylistRemove(playlist.id)),

                  actionIcon: Icons.more_vert,
                  onActionTap: () =>
                      PlaylistSheetWidget(playlist.id).show(context),
                  // trailing: IconButton(
                  //   style: Theme.of(context).iconButtonTheme.style,
                  //   onPressed: onTap != null
                  //       ? () => onTap?.call(playlist.id)
                  //       : () {
                  //           bloc.add(PlaylistToggleFavorite(playlist));
                  //         },
                  //   icon: Icon(
                  //     showFab
                  //         ? playlist.isFavorite
                  //             ? Icons.favorite
                  //             : Icons.favorite_outline_outlined
                  //         : Icons.playlist_add,
                );
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
