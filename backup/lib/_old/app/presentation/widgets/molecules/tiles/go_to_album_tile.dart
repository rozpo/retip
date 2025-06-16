import 'package:flutter/material.dart';
import '../../../../domain/cases/get_album.dart';
import '../../../pages/album/album_page.dart';
import '../more_tile.dart';
import '../../../../../core/l10n/retip_l10n.dart';
import '../../../../../core/router/retip_router.dart';

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
                return AlbumPage(album: album);
              },
            ),
          );

          refresh?.call();
        }
      },
    );
  }
}
