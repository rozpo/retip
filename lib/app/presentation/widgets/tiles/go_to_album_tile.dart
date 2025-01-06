import 'package:flutter/material.dart';
import 'package:retip/app/domain/cases/get_album.dart';
import 'package:retip/app/presentation/pages/album/album_view.dart';
import 'package:retip/app/presentation/widgets/more/more_tile.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/router/retip_router.dart';

class GoToAlbumTile extends StatelessWidget {
  final VoidCallback? refresh;
  final int albumId;

  const GoToAlbumTile(
    this.albumId, {
    this.refresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MoreTile(
      icon: Icons.album,
      text: RetipL10n.of(context).goToAlbum,
      onTap: () async {
        final album = await GetAlbum.call(albumId);

        if (context.mounted) {
          Navigator.of(context).pop();

          final isShellRoute = RetipRouter.shellNavKey.currentContext != null;

          final contextToPush =
              isShellRoute ? RetipRouter.shellNavKey.currentContext! : context;

          final rootContext = RetipRouter.rootNavKey.currentContext;

          if (rootContext != null) {
            while (Navigator.of(rootContext).canPop()) {
              Navigator.of(rootContext).pop();
            }
          }

          await Navigator.of(contextToPush).push(
            MaterialPageRoute(
              builder: (context) {
                return AlbumView(album: album);
              },
            ),
          );

          refresh?.call();
        }
      },
    );
  }
}
