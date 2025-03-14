import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/track_repository.dart';
import '../widgets/organisms/tracks_list_widget.dart';

class GenrePage extends StatelessWidget {
  final int genreId;

  const GenrePage(this.genreId, {super.key});

  @override
  Widget build(BuildContext context) {
    final trackRepository = context.read<TrackRepository>();

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: trackRepository.streamByGenre(genreId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final tracks = snapshot.requireData;

          return TracksListWidget(tracks: tracks);
        },
      ),
    );
  }
}
