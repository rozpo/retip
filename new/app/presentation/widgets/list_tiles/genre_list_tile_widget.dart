import 'package:flutter/material.dart';

import '../../../domain/entites/genre_entity.dart';
import '../modal_bottom_sheets/genre_modal_bottom_sheet_widget.dart';

class GenreListTileWidget extends StatelessWidget {
  final GenreEntity genre;
  final VoidCallback? onTap;

  const GenreListTileWidget({
    required this.genre,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(genre.name),
      leading: const CircleAvatar(
        child: Icon(Icons.category_outlined),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          GenreModalBottomSheetWidget(genre).show(context);
        },
      ),
    );
  }
}
