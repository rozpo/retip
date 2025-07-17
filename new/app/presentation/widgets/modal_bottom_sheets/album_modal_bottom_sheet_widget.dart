import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_routes.dart';
import '../../../domain/entites/album_entity.dart';
import '../../../domain/mixins/modal_bottom_sheet_mixin.dart';

class AlbumModalBottomSheetWidget extends StatelessWidget
    with ModalBottomSheetMixin {
  final AlbumEntity album;

  const AlbumModalBottomSheetWidget(
    this.album, {
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
                'id': album.artistId.toString(),
              },
            );
          },
        ),
        ListTile(
          title: const Text('Show album'),
          onTap: () {
            context.pop();
            context.pushNamed(
              RetipRoutes.album,
              pathParameters: {
                'id': album.albumId.toString(),
              },
            );
          },
        ),
      ],
    );
  }
}
