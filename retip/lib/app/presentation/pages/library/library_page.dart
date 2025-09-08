import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/presentation/blocs/track/track_bloc.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Library')),
      body: BlocBuilder<TrackBloc, TrackState>(
        builder: (context, state) {
          final tracks = <TrackEntity>[];

          if (state is TrackIdleState) {
            tracks.addAll(state.tracks);
          }

          return ListView.builder(
            itemCount: tracks.length,
            itemBuilder: (context, index) {
              final track = tracks[index];

              return ListTile(
                leading: Icon(Icons.music_note),
                title: Text(track.title),
                subtitle: Text(track.artist),
              );
            },
          );
        },
      ),
    );
  }
}
