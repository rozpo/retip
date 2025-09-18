import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/domain/repositories/track_repository.dart';
import 'package:retip/app/domain/services/audio_service.dart';
import 'package:retip/app/presentation/blocs/track/track_bloc.dart';
import 'package:retip/app/presentation/widgets/tiles/track_list_tile_widget.dart';

import '../../../blocs/album/album_bloc.dart';

class AlbumPage extends StatelessWidget {
  final int id;

  const AlbumPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;

    return BlocBuilder<AlbumBloc, AlbumState>(
      builder: (context, state) {
        if (state is! AlbumIdleState) {
          return Scaffold(
            appBar: AppBar(),
          );
        }

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.shuffle),
          ),
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                ],
                stretch: true,
                expandedHeight: shortestSide,
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1.25,
                  collapseMode: CollapseMode.pin,
                  centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Album ${state.albums.length}', textAlign: TextAlign.center),
                  ),
                  background: Center(
                    child: Card(
                      child: SizedBox.square(
                        dimension: shortestSide / 2,
                        child: Icon(Icons.album, size: shortestSide / 3),
                      ),
                    ),
                  ),
                ),
                pinned: true,
              ),
              BlocBuilder<TrackBloc, TrackState>(
                bloc: TrackBloc(context.read<TrackRepository>())
                  ..add(TrackFetchByAlbumEvent(id)),
                builder: (context, state) {
                  final tracks = <TrackEntity>[];

                  if (state is TrackIdleState) {
                    tracks.addAll(state.tracks);
                  }

                  return SliverList.builder(
                    itemCount: tracks.length,
                    itemBuilder: (context, index) {
                      final track = tracks[index];

                      return TrackListTileWidget(
                        track,
                        onTap: () {
                          context.read<AudioService>().setQueue(
                            tracks,
                            index: index,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
