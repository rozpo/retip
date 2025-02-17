import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';

import '../../domain/entities/artist.dart';

class ArtistsView extends StatelessWidget {
  const ArtistsView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Artist>>(
      stream: GetIt.I
          .get<Store>()
          .box<Artist>()
          .query()
          .watch(triggerImmediately: true)
          .map((query) => query.find()),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            final artist = snapshot.data![index];

            return ListTile(
              title: Text(artist.name),
            );
          },
        );
      },
    );
  }
}
