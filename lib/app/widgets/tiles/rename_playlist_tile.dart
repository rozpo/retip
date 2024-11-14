import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/playlist/update_playlist.dart';
import 'package:retip/app/services/entities/playlist_entity.dart';
import 'package:retip/app/widgets/more/more_tile.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class RenamePlaylistTile extends StatelessWidget {
  final PlaylistEntity entity;
  final VoidCallback? onTap;

  const RenamePlaylistTile(
    this.entity, {
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return MoreTile(
      icon: Icons.edit_note,
      text: l10n.renamePlaylist,
      onTap: () async {
        String text = '';

        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(hintText: l10n.renamePlaylist),
                  onChanged: (value) {
                    text = value;
                  },
                ),
              ],
            ),
            actions: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(l10n.cancel)),
              FilledButton(
                onPressed: () async {
                  if (text.isNotEmpty) {
                    entity.name = text;
                    await UpdatePlaylist.call(entity);

                    if (context.mounted) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }

                    onTap?.call();
                  }
                },
                child: Text(l10n.rename),
              ),
            ],
          ),
        );
      },
    );
  }
}
