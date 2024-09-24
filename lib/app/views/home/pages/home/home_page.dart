import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/data/repositories/on_audio_query_repository.dart';
import 'package:retip/app/views/home/bloc/home_bloc.dart';
import 'package:retip/app/views/player/player_view.dart';
import 'package:retip/app/widgets/player/player_widget.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class HomePage2 extends StatelessWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = HomeBloc(repository: OnAudioQueryRepository());
        return bloc..add(HomeGetTracksEvent());
      },
      child: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
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
            final player = GetIt.instance.get<RetipAudio>();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: tracks.length,
                    itemBuilder: (context, index) {
                      final track = tracks[index];

                      return ListTile(
                        onTap: () async {
                          bloc.add(HomePlayTrackEvent(index));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PlayerView(
                                player: GetIt.instance.get<RetipAudio>(),
                              ),
                            ),
                          );
                        },
                        leading: track.artwork != null
                            ? SizedBox.square(
                                dimension: 50,
                                child: Image.memory(
                                  track.artwork!,
                                  cacheHeight: 50,
                                  cacheWidth: 50,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : CircleAvatar(
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
                        trailing: StreamBuilder<int?>(
                          stream: player.currentIndexStream,
                          builder: (context, snapshot) {
                            final audioIndex = snapshot.data ?? 0;

                            return index == audioIndex
                                ? Icon(
                                    Icons.music_note,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )
                                : const Icon(Icons.more_vert);
                          },
                        ),
                      );
                    },
                  ),
                ),
                const PlayerWidget(),
              ],
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
