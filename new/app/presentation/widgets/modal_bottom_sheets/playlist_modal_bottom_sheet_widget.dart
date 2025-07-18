import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_routes.dart';
import '../../../domain/entites/playlist_entity.dart';
import '../../../domain/mixins/modal_bottom_sheet_mixin.dart';

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
          title: const Text('Show playlist'),
          onTap: () {
            context.pop();
            context.pushNamed(
              RetipRoutes.playlist,
              pathParameters: {
                'id': playlist.id.toString(),
              },
            );
          },
        ),
      ],
    );
  }
}
