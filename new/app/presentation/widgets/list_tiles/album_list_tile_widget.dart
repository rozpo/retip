import 'package:flutter/material.dart';

import '../../../domain/entites/album_entity.dart';
import '../modal_bottom_sheets/album_modal_bottom_sheet_widget.dart';

class AlbumListTileWidget extends StatelessWidget {
  final AlbumEntity album;
  final VoidCallback? onTap;

  const AlbumListTileWidget({
    required this.album,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(album.title),
      subtitle: Text(album.artist),
      leading: const CircleAvatar(
        child: Icon(Icons.album_outlined),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          AlbumModalBottomSheetWidget(album).show(context);
        },
      ),
    );
  }
}
