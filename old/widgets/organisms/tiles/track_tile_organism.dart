import 'package:flutter/material.dart';

import '../../../new/app/domain/entities/track_entity.dart';
import '../../atoms/icon_atom.dart';
import '../../atoms/icon_button_atom.dart';
import '../../molecules/list_tile_molecule.dart';

class TrackTileOrganism extends StatelessWidget {
  final TrackEntity track;

  const TrackTileOrganism(this.track, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTileMolecule(
      leading: const IconAtom(Icons.music_note),
      subtitle: track.artist?.name,
      title: track.title,
      trailing: IconButtonAtom(
        iconData: Icons.more_vert,
        onPressed: () {},
      ),
    );
  }
}
