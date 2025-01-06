import 'package:flutter/material.dart';
import 'package:retip/app/domain/cases/get_artist.dart';
import 'package:retip/app/presentation/views/artist/artist_view.dart';
import 'package:retip/app/presentation/widgets/more/more_tile.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/router/retip_router.dart';

class GoToArtistTile extends StatelessWidget {
  final VoidCallback? refresh;
  final int artistId;

  const GoToArtistTile(
    this.artistId, {
    this.refresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MoreTile(
      icon: Icons.person,
      text: RetipL10n.of(context).goToArtist,
      onTap: () async {
        final artist = await GetArtist.call(artistId);

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
                return ArtistView(artist: artist);
              },
            ),
          );

          refresh?.call();
        }
      },
    );
  }
}
