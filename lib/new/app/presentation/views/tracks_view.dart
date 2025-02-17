import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';

import '../../data/models/track_model.dart';
import '../../domain/entities/track_entity.dart';

class TracksView extends StatelessWidget {
  const TracksView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TrackEntity>>(
      stream: GetIt.I
          .get<Store>()
          .box<TrackModel>()
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
