import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/l10n/retip_l10n.dart';
import '../../../../../core/utils/show_bottom_sheet_action.dart';
import '../../../../domain/repositories/playlist_repository.dart';
import '../../atoms/divider_widget.dart';
import '../../atoms/spacer_widget.dart';
import '../../molecules/list_tile_widget.dart';

class PlaylistSheetWidget extends StatelessWidget with ShowBottomSheetAction {
  final int playlistId;

  const PlaylistSheetWidget(
    this.playlistId, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.read<RetipL10n>().of(context);
    final repository = context.read<PlaylistRepository>();

    return StreamBuilder(
        stream: repository.read(playlistId),
        builder: (context, snapshot) {
          if (snapshot.hasData == false || snapshot.requireData == null) {
            return const SizedBox();
          }

          final playlist = snapshot.requireData!;

          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SpacerWidget(),
                ListTileWidget(
                  tileIcon: Icons.playlist_play,
                  title: playlist.name,
                  subtitle: '${playlist.tracks.length} tracks',
                  actionIcon: playlist.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  onActionTap: () {
                    repository.toggleFavorite(playlist);
                  },
                ),
                const SpacerWidget(),
                const DividerWidget(),
                const SpacerWidget(),
                ListTileWidget(
                  tileIcon: Icons.playlist_play,
                  title: l10n.playNext,
                ),
                ListTileWidget(
                  tileIcon: Icons.queue_music,
                  title: l10n.addToQueue,
                ),
                const DividerWidget(),
                ListTileWidget(
                  tileIcon: Icons.photo,
                  title: l10n.changeCover,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTileWidget(
                  tileIcon: Icons.edit,
                  title: l10n.renamePlaylist,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final controller = TextEditingController();
                        final formKey = GlobalKey<FormState>();

                        return Form(
                          key: formKey,
                          child: AlertDialog(
                            shape: const BeveledRectangleBorder(),
                            content: TextFormField(
                              validator: (value) {
                                if (value?.trim().isEmpty == true) {
                                  return l10n.playlistNameIsRequired;
                                }
                                return null;
                              },
                              controller: controller,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                labelText: l10n.newName,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(l10n.cancel),
                              ),
                              FilledButton(
                                onPressed: () {
                                  if (formKey.currentState?.validate() ==
                                      false) {
                                    return;
                                  }

                                  playlist.name = controller.text;
                                  repository.update(playlist);
                                  Navigator.pop(context);
                                },
                                child: Text(l10n.rename),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                const DividerWidget(),
                ListTileWidget(
                  tileIcon: Icons.delete_forever,
                  title: l10n.deletePlaylist,
                  onTap: () {
                    Navigator.pop(context);
                    repository.delete(playlist.id);
                  },
                ),
              ],
            ),
          );
        });
  }
}
