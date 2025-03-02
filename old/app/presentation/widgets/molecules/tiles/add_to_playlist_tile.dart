import 'package:flutter/material.dart';
import '../../../../domain/cases/playlist/create_playlist.dart';
import '../../../../domain/cases/playlist/get_all_playlists.dart';
import '../../../../domain/cases/playlist/update_playlist.dart';
import '../../../../domain/entities/track_entity.dart';
import '../../atoms/single_line_text.dart';
import '../more_tile.dart';
import '../../atoms/playlist_artwork.dart';
import '../rp_divider.dart';
import '../../atoms/rp_icon.dart';
import '../rp_snackbar.dart';
import '../../atoms/spacer.dart';
import '../../../../../core/l10n/retip_l10n.dart';
import '../../../../../core/router/retip_router.dart';
import '../../../../../core/utils/sizer.dart';

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
            context: RetipRouter.rootNavKey.currentContext ?? context,
            builder: (context) {
              return SafeArea(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: Sizer.x1),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: playlists.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          ListTile(
                            leading: const RpIcon(icon: Icons.playlist_add),
                            title:
                                Text(RetipL10n.of(context).createNewPlaylist),
                            onTap: () async {
                              String text = '';

                              await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(l10n.createNewPlaylist),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(Sizer.x1),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: l10n.myAwesomePlaylist,
                                        ),
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
                                                    const WidgetStatePropertyAll(
                                                        EdgeInsets.zero),
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                shape: WidgetStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Sizer.x0_5),
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
                                                    const WidgetStatePropertyAll(
                                                        EdgeInsets.zero),
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                shape: WidgetStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Sizer.x0_5),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () async {
                                                if (text.isNotEmpty) {
                                                  await CreatePlaylist.call(
                                                      text, track);

                                                  if (context.mounted) {
                                                    final message =
                                                        l10n.addedTo(text);
                                                    final snackbar = RpSnackbar(
                                                        context,
                                                        message: message);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .removeCurrentSnackBar();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackbar);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  }
                                                }
                                              },
                                              child: Text(l10n.create),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const RpDivider(),
                        ],
                      );
                    }

                    final pl = playlists[index - 1];

                    return ListTile(
                      leading: SizedBox.square(
                        dimension: Sizer.x5,
                        child: PlaylistArtwork(images: pl.artworks),
                      ),
                      subtitle: SingleLineText(
                        RetipL10n.of(context)
                            .tracksCount(pl.tracks.length)
                            .toLowerCase(),
                      ),
                      title: SingleLineText(pl.name),
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
                ),
              );
            },
          );
        }
      },
    );
  }
}
