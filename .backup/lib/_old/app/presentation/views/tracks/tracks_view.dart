import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/tracks_bloc.dart';
import 'widgets/tracks_empty_widget.dart';
import 'widgets/tracks_list_widget.dart';

class TracksView extends StatelessWidget {
  const TracksView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TracksBloc>();

    return BlocBuilder<TracksBloc, TracksState>(
      builder: (context, state) {
        if (state.tracks.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              final stream = bloc.stream.first;
              bloc.add(FetchTracksEvent());

              await stream;
            },
            child: TracksListWidget(
              onTap: (index) => bloc.add(PlayTracksEvent(index: index)),
              tracks: state.tracks,
            ),
          );
        }

        return const TracksEmptyWidget();
      },
    );
  }
}
