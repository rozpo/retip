import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/playlist/delete_playlist.dart';
import 'package:retip/app/services/entities/playlist_entity.dart';
import 'package:retip/app/widgets/more/more_tile.dart';
import 'package:retip/app/widgets/rp_snackbar.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/router/retip_router.dart';

class DeletePlaylistTile extends StatelessWidget {
  final PlaylistEntity entity;
  final VoidCallback? onTap;

  const DeletePlaylistTile(
    this.entity, {
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return MoreTile(
      icon: Icons.delete_forever,
      text: l10n.deletePlaylist,
      onTap: () async {
        await DeletePlaylist.call(entity.id);
        if (context.mounted) {
          // Close modal bottom sheet
          Navigator.pop(context);

          final message = l10n.playlistDeleted;
          final snackbar = RpSnackbar(context, message: message);

          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackbar);

          // Close playlist view
          final shellContext = RetipRouter.shellNavKey.currentContext;
          if (shellContext != null) {
            Navigator.pop(shellContext);
          }

          onTap?.call();
        }
      },
    );
  }
}
