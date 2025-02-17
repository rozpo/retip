import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:objectbox/objectbox.dart';

import '../../domain/entities/album.dart';

class AlbumsView extends StatelessWidget {
  const AlbumsView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Album>>(
      stream: GetIt.I
          .get<Store>()
          .box<Album>()
          .query()
          .watch(triggerImmediately: true)
          .map((query) => query.find()),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            final album = snapshot.data![index];

            return ListTile(
              title: Text(album.title),
              subtitle: Text(album.artist),
            );
          },
        );
      },
    );
  }
}
