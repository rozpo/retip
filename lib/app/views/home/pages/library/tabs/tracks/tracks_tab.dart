import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/favourites/add_to_favourites.dart';
import 'package:retip/app/services/cases/favourites/is_in_favourites.dart';
import 'package:retip/app/services/cases/favourites/remove_from_favourites.dart';
import 'package:retip/app/services/cases/get_all_tracks.dart';
import 'package:retip/app/services/cases/play_audio.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/widgets/buttons/favourite_button.dart';
import 'package:retip/app/widgets/track_tile.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

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
              child: CircularProgressIndicator(),
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
            itemCount: snapshot.requireData.length,
            itemBuilder: (context, index) {
              final track = snapshot.requireData[index];
              final isFavourite = IsInFavourites.call(track);

              return TrackTile(
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
