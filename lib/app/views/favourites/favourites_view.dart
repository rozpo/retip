import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/services/cases/play_audio.dart';
import 'package:retip/app/widgets/buttons/play_button.dart';
import 'package:retip/app/widgets/buttons/shuffle_button.dart';
import 'package:retip/app/widgets/player_widget.dart';
import 'package:retip/app/widgets/playlist_artwork.dart';
import 'package:retip/app/widgets/spacer.dart';
import 'package:retip/app/widgets/track_tile.dart';
import 'package:retip/app/widgets/tracks_header.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'bloc/favourites_bloc.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);
    final bloc = context.read<FavouritesBloc>();

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<FavouritesBloc, FavouritesState>(
          builder: (context, state) {
            return Text(state.title);
          },
        ),
      ),
      body: BlocBuilder<FavouritesBloc, FavouritesState>(
        bloc: bloc..add(GetFavouritesEvent()),
        builder: (context, state) {
          final tracks = state.tracks;

          if (tracks.isEmpty) {
            return Center(
              child: Text(l10n.noTracks),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              final stream = bloc.stream.first;
              bloc.add(GetFavouritesEvent());

              await stream;
            },
            child: ListView.builder(
              controller: bloc.scrollController,
              itemCount: tracks.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizer.x1),
                    child: Column(
                      // shrinkWrap: true,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox.square(
                          dimension: MediaQuery.of(context).size.width / 2,
                          child: const PlaylistArtwork(
                            icon: Icons.favorite,
                          ),
                        ),
                        const VerticalSpacer(),
                        VisibilityDetector(
                          key: bloc.titleKey,
                          onVisibilityChanged: (info) {
                            if (info.visibleFraction > 0.9) {
                              bloc.add(UpdateTitleEvent());
                            } else {
                              bloc.add(UpdateTitleEvent(l10n.favourites));
                            }
                          },
                          child: Text(
                            l10n.favourites,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                            '${RetipL10n.of(context).playlist} - ${RetipL10n.of(context).tracksCount(state.tracks.length)}'),
                        const SizedBox(height: Sizer.x1),
                        Row(
                          children: [
                            Expanded(
                              child: ShuffleButton(
                                onPressed: () => PlayAudio.call(
                                  state.tracks,
                                  shuffle: true,
                                ),
                              ),
                            ),
                            const HorizontalSpacer(),
                            Expanded(
                              child: PlayButton(
                                onPressed: () => PlayAudio.call(
                                  state.tracks,
                                  shuffle: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const VerticalSpacer(),
                        const VerticalSpacer(),
                        TracksHeader(value: state.tracks.length),
                      ],
                    ),
                  );
                }

                final track = tracks[index - 1];

                return TrackTile(
                  track: track,
                  refresh: () => bloc.add(GetFavouritesEvent()),
                  onTap: () => PlayAudio.call(tracks, index: index - 1),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: const SafeArea(
          child: PlayerWidget(),
        ),
      ),
    );
  }
}