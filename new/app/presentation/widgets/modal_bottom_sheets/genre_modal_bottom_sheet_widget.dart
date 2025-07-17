import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_routes.dart';
import '../../../domain/entites/genre_entity.dart';
import '../../../domain/mixins/modal_bottom_sheet_mixin.dart';

class GenreModalBottomSheetWidget extends StatelessWidget
    with ModalBottomSheetMixin {
  final GenreEntity genre;

  const GenreModalBottomSheetWidget(
    this.genre, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Show genre'),
          onTap: () {
            context.pop();
            context.pushNamed(
              RetipRoutes.genre,
              pathParameters: {
                'id': genre.genreId.toString(),
              },
            );
          },
        ),
      ],
    );
  }
}
