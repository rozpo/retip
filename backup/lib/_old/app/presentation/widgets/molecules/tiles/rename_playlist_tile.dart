import 'package:flutter/material.dart';
import '../../../../domain/cases/playlist/update_playlist.dart';
import '../../../../domain/entities/playlist_entity.dart';
import '../more_tile.dart';
import '../../atoms/spacer.dart';
import '../../../../../core/l10n/retip_l10n.dart';
import '../../../../../core/utils/sizer.dart';

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
            title: Text(l10n.renamePlaylist),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizer.x1)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(hintText: l10n.myAwesomePlaylist),
                  onChanged: (value) {
                    text = value;
                  },
                ),
                const VerticalSpacer(),
                const VerticalSpacer(),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: ButtonStyle(
                          padding:
                              const WidgetStatePropertyAll(EdgeInsets.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Sizer.x0_5),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(l10n.cancel),
                      ),
                    ),
                    const HorizontalSpacer(),
                    Expanded(
                      child: FilledButton(
                        style: ButtonStyle(
                          padding:
                              const WidgetStatePropertyAll(EdgeInsets.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Sizer.x0_5),
                            ),
                          ),
                        ),
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
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
