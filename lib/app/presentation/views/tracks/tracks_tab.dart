import 'package:flutter/material.dart';
import '../../../domain/cases/favourites/add_to_favourites.dart';
import '../../../domain/cases/favourites/is_in_favourites.dart';
import '../../../domain/cases/favourites/remove_from_favourites.dart';
import '../../../domain/cases/get_all_tracks.dart';
import '../../../domain/cases/play_audio.dart';
import '../../../domain/entities/track_entity.dart';
import '../../widgets/atoms/favourite_button.dart';
import '../../widgets/molecules/tiles/track_tile.dart';
import '../../../../core/l10n/retip_l10n.dart';
import '../../../../core/utils/sizer.dart';

import '../../widgets/atoms/spinner_widget.dart';

class TracksTab extends StatefulWidget {
  const TracksTab({super.key});

  @override
  State<TracksTab> createState() => _TracksTabState();
}

class _TracksTabState extends State<TracksTab> {
  static Future<List<TrackEntity>> future = GetAllTracks.call();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: SpinnerWidget(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.hasData == false || snapshot.requireData.isEmpty) {
            return Center(
              child: Text(RetipL10n.of(context).noTracks),
            );
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: Sizer.x1),
            itemCount: snapshot.requireData.length,
            itemBuilder: (context, index) {
              final track = snapshot.requireData[index];
              final isFavourite = IsInFavourites.call(track);

              return TrackTile(
                refresh: () => setState(() {}),
                track: track,
                quickAction: FavouriteButton(
                  isFavourite: isFavourite,
                  onPressed: () {
                    if (isFavourite) {
                      RemoveFromFavourites.call(track);
                    } else {
                      AddToFavourites.call(track);
                    }

                    setState(() {});
                  },
                ),
                onTap: () => PlayAudio.call(
                  snapshot.requireData,
                  index: index,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
