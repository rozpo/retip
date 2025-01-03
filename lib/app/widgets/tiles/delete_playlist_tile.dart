import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/playlist/delete_playlist.dart';
import 'package:retip/app/services/entities/playlist_entity.dart';
import 'package:retip/app/widgets/more/more_tile.dart';
import 'package:retip/app/widgets/rp_snackbar.dart';
import 'package:retip/app/widgets/spacer.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/router/retip_router.dart';
import 'package:retip/core/utils/sizer.dart';

class DeletePlaylistTile extends StatelessWidget {
  final PlaylistEntity entity;
  final VoidCallback? onTap;

  const DeletePlaylistTile(
    this.entity, {
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return MoreTile(
      icon: Icons.delete_forever,
      text: l10n.deletePlaylist,
      onTap: () async {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.deletePlaylist),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizer.x1)),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.areYouSure),
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
                        child: Text(l10n.cancel.toUpperCase()),
                      ),
                    ),
                    const HorizontalSpacer(),
                    Expanded(
                      child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.errorContainer),
                          foregroundColor: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.onErrorContainer),
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
                          await DeletePlaylist.call(entity.id);
                          if (context.mounted) {
                            // Close modal bottom sheet
                            Navigator.pop(context);
                            Navigator.pop(context);

                            final message = l10n.playlistDeleted;
                            final snackbar =
                                RpSnackbar(context, message: message);

                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);

                            // Close playlist view
                            final shellContext =
                                RetipRouter.shellNavKey.currentContext;
                            if (shellContext != null) {
                              Navigator.pop(shellContext);
                            }

                            onTap?.call();
                          }
                        },
                        child: Text(l10n.delete.toUpperCase()),
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
