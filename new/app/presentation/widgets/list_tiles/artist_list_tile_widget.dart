import 'package:flutter/material.dart';

import '../../../domain/entites/artist_entity.dart';
import '../modal_bottom_sheets/artist_modal_bottom_sheet_widget.dart';

class ArtistListTileWidget extends StatelessWidget {
  final ArtistEntity artist;
  final VoidCallback? onTap;

  const ArtistListTileWidget({
    required this.artist,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(artist.name),
      leading: const CircleAvatar(
        child: Icon(Icons.person_outlined),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          ArtistModalBottomSheetWidget(artist).show(context);
        },
      ),
    );
  }
}
