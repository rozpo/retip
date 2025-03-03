import 'package:flutter/material.dart';

import '../../../core/utils/sizer.dart';
import '../widgets/molecules/list_tile_molecule.dart';
import '../widgets/templates/playlist_template.dart';

class PlaylistsView extends StatelessWidget {
  const PlaylistsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: Sizer.small),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTileMolecule(
          icon: Icons.playlist_play,
          title: 'Playlist $index',
          subtitle: 'Description $index',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaylistTemplate(
                  title: 'Playlist $index',
                ),
              ),
            );
          },
        );
      },
    );
  }
}
