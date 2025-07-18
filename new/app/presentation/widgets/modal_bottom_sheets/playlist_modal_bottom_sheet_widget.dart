import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entites/playlist_entity.dart';
import '../../../domain/mixins/modal_bottom_sheet_mixin.dart';
import '../../../domain/services/playlist_service.dart';

class PlaylistModalBottomSheetWidget extends StatelessWidget
    with ModalBottomSheetMixin {
  final PlaylistEntity playlist;

  const PlaylistModalBottomSheetWidget(
    this.playlist, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Rename playlist'),
          onTap: () {
            context.pop();
            context
                .read<PlaylistService>()
                .rename(playlist.id, const Uuid().v4());
          },
        ),
        ListTile(
          title: const Text('Delete playlist'),
          onTap: () {
            context.pop();
            context.read<PlaylistService>().delete(playlist.id);
          },
        ),
      ],
    );
  }
}
