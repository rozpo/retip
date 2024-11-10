import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/playlist/get_all_playlists.dart';
import 'package:retip/app/services/cases/playlist/update_playlist.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/widgets/more/more_tile.dart';
import 'package:retip/app/widgets/rp_snackbar.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class AddToPlaylistTile extends StatelessWidget {
  final TrackEntity track;
  final VoidCallback? onTap;

  const AddToPlaylistTile({
    required this.track,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return MoreTile(
      icon: Icons.playlist_add,
      text: l10n.addToPlaylist,
      onTap: () async {
        Navigator.of(context).pop();
        final playlists = await GetAllPlaylists.call();

        if (context.mounted) {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              // return AlertDialog(
              // scrollable: true,
              return ListView.builder(
                shrinkWrap: true,
                itemCount: playlists.length,
                itemBuilder: (context, index) {
                  final pl = playlists[index];

                  return ListTile(
                    title: Text(pl.name),
                    subtitle: Text(
                        RetipL10n.of(context).tracksCount(pl.tracks.length)),
                    onTap: () {
                      pl.tracks.add(track);
                      UpdatePlaylist.call(pl);
                      final message = l10n.addedTo(pl.name);
                      final snackbar = RpSnackbar(context, message: message);

                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
              // );
            },
          );
        }
      },
    );
  }
}
