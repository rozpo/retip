import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/data/repositories/on_audio_query_repository.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

import 'bloc/home_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = HomeBloc(repository: OnAudioQueryRepository());
        return bloc..add(HomeGetTracksEvent());
      },
      child: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(RetipL10n.of(context).retip),
        actions: [
          IconButton(
            onPressed: () => bloc.add(HomeSortTracksEvent()),
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeIdleState) {
            final tracks = state.tracks;

            return ListView.builder(
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                final track = tracks[index];

                return ListTile(
                  onTap: () async => bloc.add(HomePlayTrackEvent(index)),
                  leading: CircleAvatar(
                    child: Text(track.title[0]),
                  ),
                  title: Text(track.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(track.album),
                      Text(track.artist),
                    ],
                  ),
                  trailing: const Icon(Icons.more_vert),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
