import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';

import '../../domain/entities/track.dart';

class TracksView extends StatelessWidget {
  const TracksView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Track>>(
      stream: GetIt.I
          .get<Store>()
          .box<Track>()
          .query()
          .watch(triggerImmediately: true)
          .map((query) => query.find()),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            final track = snapshot.data![index];

            return ListTile(
              title: Text(track.title),
              subtitle: Text(track.artist),
            );
          },
        );
      },
    );
  }
}
