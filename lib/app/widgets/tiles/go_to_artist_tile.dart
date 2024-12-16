import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/get_artist.dart';
import 'package:retip/app/views/artist/artist_view.dart';
import 'package:retip/app/widgets/more/more_tile.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

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
          await Navigator.of(context).push(
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
