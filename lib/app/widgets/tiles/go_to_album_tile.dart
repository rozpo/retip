import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/get_album.dart';
import 'package:retip/app/views/album/album_view.dart';
import 'package:retip/app/widgets/more/more_tile.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

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
          await Navigator.of(context).push(
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
