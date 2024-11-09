import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/get_artist.dart';
import 'package:retip/app/views/home/pages/artist/artist_page.dart';
import 'package:retip/app/widgets/more/more_tile.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class GoToArtistTile extends StatelessWidget {
  final int artistId;

  const GoToArtistTile(
    this.artistId, {
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ArtistPage(artist: artist);
              },
            ),
          );
        }
      },
    );
  }
}
