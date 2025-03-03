import 'package:flutter/material.dart';
import '../../../../domain/cases/playlist/update_playlist.dart';
import '../../../../domain/entities/playlist_entity.dart';
import '../../../../domain/entities/track_entity.dart';
import '../more_tile.dart';
import '../rp_snackbar.dart';
import '../../../../../core/l10n/retip_l10n.dart';

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
      },
    );
  }
}
