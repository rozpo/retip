import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/playlist/update_playlist.dart';
import 'package:retip/app/services/entities/playlist_entity.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/widgets/more/more_tile.dart';
import 'package:retip/app/widgets/rp_snackbar.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class RemoveFromPlaylistTile extends StatelessWidget {
  final TrackEntity track;
  final PlaylistEntity playlist;
  final VoidCallback? onTap;

  const RemoveFromPlaylistTile({
    required this.track,
    required this.playlist,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return MoreTile(
      icon: Icons.playlist_remove,
      text: l10n.removeFromPlaylist,
      onTap: () async {
        Navigator.of(context).pop();
        playlist.tracks.remove(track);
        UpdatePlaylist.call(playlist);
        final message = l10n.removedFrom(playlist.name);
        final snackbar = RpSnackbar(context, message: message);

        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackbar);

        onTap?.call();

        // if (context.mounted) {
        //   showModalBottomSheet(
        //     context: context,
        //     builder: (context) {
        //       // return AlertDialog(
        //       // scrollable: true,
        //       return ListView.builder(
        //         shrinkWrap: true,
        //         itemCount: playlists.length,
        //         itemBuilder: (context, index) {
        //           final pl = playlists[index];

        //           return ListTile(
        //             title: Text(pl.name),
        //             subtitle: Text(
        //                 RetipL10n.of(context).tracksCount(pl.tracks.length)),
        //             onTap: () {},
        //           );
        //         },
        //       );
        //       // );
        //     },
        //   );
        // }
      },
    );
  }
}
