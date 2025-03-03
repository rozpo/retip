import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/l10n/retip_l10n.dart';
import '../../../core/utils/sizer.dart';
import '../../../../../app/domain/entities/artist_entity.dart';
import '../../domain/usecases/artist_usecase.dart';
import '../pages/artist/artist_page.dart';
import '../widgets/molecules/list_tile_molecule.dart';

class ArtistsView extends StatelessWidget {
  const ArtistsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);
    final stream = context.read<ArtistUsecase>().allStream();

    return StreamBuilder<List<ArtistEntity>>(
      stream: stream,
      builder: (context, snapshot) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: Sizer.small),
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            final artist = snapshot.data![index];

            return ListTileMolecule(
              subtitle: l10n.albumsCount(artist.albums.length),
              icon: Icons.person,
              title: artist.name,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ArtistPage(id: artist.id);
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
