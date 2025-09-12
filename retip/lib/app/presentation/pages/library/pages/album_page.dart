import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/domain/repositories/track_repository.dart';
import 'package:retip/app/domain/services/audio_service.dart';
import 'package:retip/app/presentation/blocs/track/track_bloc.dart';
import 'package:retip/app/presentation/widgets/tiles/track_list_tile_widget.dart';

class AlbumPage extends StatelessWidget {
  final int id;

  const AlbumPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Album $id')),
      body: BlocBuilder<TrackBloc, TrackState>(
        bloc: TrackBloc(context.read<TrackRepository>())
          ..add(TrackFetchByAlbumEvent(id)),
        builder: (context, state) {
          final tracks = <TrackEntity>[];

          if (state is TrackIdleState) {
            tracks.addAll(state.tracks);
          }

          return ListView.builder(
            itemCount: tracks.length,
            itemBuilder: (context, index) {
              final track = tracks[index];

              return TrackListTileWidget(
                track,
                onTap: () {
                  context.read<AudioService>().setQueue(tracks, index: index);
                },
              );
            },
          );
        },
      ),
    );
  }
}
