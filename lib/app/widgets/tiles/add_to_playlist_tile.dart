import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/playlist/create_playlist.dart';
import 'package:retip/app/services/cases/playlist/get_all_playlists.dart';
import 'package:retip/app/services/cases/playlist/update_playlist.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/widgets/more/more_tile.dart';
import 'package:retip/app/widgets/playlist_artwork.dart';
import 'package:retip/app/widgets/rp_divider.dart';
import 'package:retip/app/widgets/rp_icon.dart';
import 'package:retip/app/widgets/rp_list_tile.dart';
import 'package:retip/app/widgets/rp_snackbar.dart';
import 'package:retip/app/widgets/rp_text.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';

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
        final playlists = await GetAllPlaylists.call();

        if (context.mounted) {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            context: context,
            builder: (context) {
              return ListView.builder(
                // separatorBuilder: (context, index) {
                //   return VerticalSpacer();
                // },
                padding: const EdgeInsets.symmetric(vertical: Sizer.x1),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: playlists.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        RpListTile(
                          leading: const RpIcon(icon: Icons.playlist_add),
                          title: Text(RetipL10n.of(context).createNewPlaylist),
                          onTap: () async {
                            String text = '';

                            await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                          hintText: l10n.nameNewPlaylist),
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
                                        await CreatePlaylist.call(text, track);

                                        if (context.mounted) {
                                          final message = l10n.addedTo(text);
                                          final snackbar = RpSnackbar(context,
                                              message: message);
                                          ScaffoldMessenger.of(context)
                                              .removeCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackbar);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                    child: Text(l10n.create),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const RpDivider(),
                      ],
                    );
                  }

                  final pl = playlists[index - 1];

                  return RpListTile(
                    leading: SizedBox.square(
                      dimension: Sizer.x5,
                      child: PlaylistArtwork(images: pl.artworks),
                    ),
                    subtitle: RpText(
                      RetipL10n.of(context)
                          .tracksCount(pl.tracks.length)
                          .toLowerCase(),
                    ),
                    title: RpText(pl.name),
                    onTap: () {
                      pl.tracks.add(track);
                      UpdatePlaylist.call(pl);
                      final message = l10n.addedTo(pl.name);
                      final snackbar = RpSnackbar(context, message: message);

                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
