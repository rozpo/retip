import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/l10n/retip_l10n.dart';
import '../../../../../core/utils/show_bottom_sheet_action.dart';
import '../../../../domain/repositories/playlist_repository.dart';
import '../../atoms/divider_widget.dart';
import '../../atoms/spacer_widget.dart';
import '../../molecules/list_tile_widget.dart';

class SaveToPlaylistSheetWidget extends StatelessWidget
    with ShowBottomSheetAction {
  final int trackId;

  const SaveToPlaylistSheetWidget(
    this.trackId, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.read<RetipL10n>().of(context);
    final playlistRepository = context.read<PlaylistRepository>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTileWidget(
          tileIcon: Icons.playlist_add,
          title: l10n.createPlaylist,
          actionIcon: Icons.close,
          onActionTap: () => Navigator.pop(context),
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
                    title: Text(l10n.createPlaylist),
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
                        hintText: l10n.playlistName,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(l10n.cancel),
                      ),
                      FilledButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() == false) return;
                          playlistRepository.create(controller.text);
                          Navigator.pop(context);
                        },
                        child: Text(l10n.create),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        const SpacerWidget(),
        const DividerWidget(),
        StreamBuilder(
          stream: playlistRepository.stream(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) return const SizedBox();

            final playlists = snapshot.requireData;

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              shrinkWrap: true,
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                final isTrackPresent =
                    playlist.tracks.map((e) => e.id).contains(trackId);

                return ListTileWidget(
                  tileIcon: Icons.playlist_play,
                  onActionTap: isTrackPresent
                      ? null
                      : () => playlistRepository.addTrack(playlist.id, trackId),
                  actionIcon: isTrackPresent
                      ? Icons.playlist_add_check
                      : Icons.playlist_add,
                  title: playlist.name,
                  onTap: isTrackPresent
                      ? null
                      : () {
                          playlistRepository.addTrack(playlist.id, trackId);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.savedToPlaylist),
                            ),
                          );
                        },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
