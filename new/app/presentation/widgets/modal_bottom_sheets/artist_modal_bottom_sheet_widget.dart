import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_routes.dart';
import '../../../domain/entites/artist_entity.dart';
import '../../../domain/mixins/modal_bottom_sheet_mixin.dart';

class ArtistModalBottomSheetWidget extends StatelessWidget
    with ModalBottomSheetMixin {
  final ArtistEntity artist;

  const ArtistModalBottomSheetWidget(
    this.artist, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Show artist'),
          onTap: () {
            context.pop();
            context.pushNamed(
              RetipRoutes.artist,
              pathParameters: {
                'id': artist.artistId.toString(),
              },
            );
          },
        ),
      ],
    );
  }
}
