import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/track_entity.dart';
import '../../../domain/usecases/track_usecase.dart';

class TracksView extends StatelessWidget {
  const TracksView({super.key});

  @override
  Widget build(BuildContext context) {
    final stream = context.read<TrackUsecase>().allStream();

    return StreamBuilder<List<TrackEntity>>(
      stream: stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Tracks (${snapshot.data?.length ?? 0})'),
          ),
          body: ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              final track = snapshot.data![index];

              return ListTile(
                title: Text(track.title),
                subtitle:
                    track.artist != null ? Text(track.artist!.name) : null,
              );
            },
          ),
        );
      },
    );
  }
}
