import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_routes.dart';
import '../../../domain/entites/track_entity.dart';
import '../../../domain/mixins/modal_bottom_sheet_mixin.dart';

class TrackModalBottomSheetWidget extends StatelessWidget
    with ModalBottomSheetMixin {
  final TrackEntity track;

  const TrackModalBottomSheetWidget(
    this.track, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Go to artist'),
          onTap: () {
            context.pop();
            context.pushNamed(
              RetipRoutes.artist,
              pathParameters: {
                'id': track.artistId.toString(),
              },
            );
          },
        ),
        ListTile(
          title: const Text('Go to album'),
          onTap: () {
            context.pop();
            context.pushNamed(
              RetipRoutes.album,
              pathParameters: {
                'id': track.albumId.toString(),
              },
            );
          },
        ),
        ListTile(
          title: const Text('Show track info'),
          onTap: () {
            context.pop();
            context.pushNamed(
              RetipRoutes.track,
              pathParameters: {
                'id': track.trackId.toString(),
              },
            );
          },
        ),
      ],
    );
  }
}
