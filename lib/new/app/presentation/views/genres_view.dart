import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/l10n/retip_l10n.dart';
import '../../../core/utils/sizer.dart';
import '../../domain/entities/genre_entity.dart';
import '../../domain/usecases/genre_usecase.dart';
import '../widgets/molecules/list_tile_molecule.dart';
import 'tracks_view.dart';

class GenresView extends StatelessWidget {
  const GenresView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);
    final stream = context.read<GenreUsecase>().allStream();

    return StreamBuilder<List<GenreEntity>>(
      stream: stream,
      builder: (context, snapshot) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: Sizer.small),
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            final genre = snapshot.data![index];

            return ListTileMolecule(
              icon: Icons.category,
              title: genre.name,
              subtitle: l10n.tracksCount(genre.tracks.length),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TracksView(genreId: genre.id);
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
