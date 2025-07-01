import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:retip/app/domain/cases/favourites/is_in_favourites.dart';
import 'package:retip/app/domain/cases/get_all_tracks.dart';
import 'package:retip/app/domain/cases/play_audio.dart';
import 'package:retip/app/presentation/widgets/atoms/single_line_text.dart';
import 'package:retip/app/presentation/widgets/atoms/more_icon.dart';
import 'package:retip/app/presentation/widgets/molecules/rp_list_tile.dart';
import 'package:retip/app/presentation/widgets/molecules/tiles/add_to_fav_tile.dart';
import 'package:retip/app/presentation/widgets/molecules/tiles/add_to_playlist_tile.dart';
import 'package:retip/app/presentation/widgets/molecules/tiles/go_to_album_tile.dart';
import 'package:retip/app/presentation/widgets/molecules/tiles/go_to_artist_tile.dart';
import 'package:retip/app/presentation/widgets/molecules/tiles/remove_from_fav_tile.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/sizer.dart';
import 'package:retip/core/utils/utils.dart';

import '../../presentation/widgets/molecules/tiles/file_details.dart';
import 'abstract_entity.dart';

abstract class TrackEntity extends AbstractEntity {
  final int? albumId;
  final String title;
  final String album;
  final String artist;
  final int? artistId;
  final Uri uri;
  final Uint8List? artwork;
  final int? index;
  final Duration duration;

  bool isFavourite = false;

  final int size;
  final String? genre;
  final String? composer;
  final DateTime? dateAdded;
  final DateTime? dateModified;
  final String fileLocation;
  final String fileType;

  final bool? isAlarm;
  final bool? isAudioBook;
  final bool? isMusic;
  final bool? isNotification;
  final bool? isPodcast;
  final bool? isRingtone;

  TrackEntity({
    required super.id,
    this.albumId,
    required this.title,
    required this.album,
    required this.artist,
    this.artistId,
    required this.uri,
    required this.duration,
    this.artwork,
    this.index,
    required this.size,
    this.genre,
    this.composer,
    this.dateAdded,
    this.dateModified,
    required this.fileLocation,
    required this.fileType,
    this.isAlarm,
    this.isAudioBook,
    this.isMusic,
    this.isNotification,
    this.isPodcast,
    this.isRingtone,
  });

  @override
  String toString() {
    return title;
  }

  @override
  String toTypeString(BuildContext context) {
    return RetipL10n.of(context).tracks;
  }

  @override
  Widget toListTile(BuildContext context, [String? query]) {
    return TrackWidget(
      entity: this,
      query: query,
    );
  }
}

class TrackWidget extends StatefulWidget {
  final TrackEntity entity;
  final String? query;

  const TrackWidget({
    required this.entity,
    this.query,
    super.key,
  });

  @override
  State<TrackWidget> createState() => _TrackWidgetState();
}

class _TrackWidgetState extends State<TrackWidget> {
  bool isFav = false;
  late TrackEntity track;

  @override
  void initState() {
    super.initState();
    track = widget.entity;
    isFav = track.isFavourite;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RpListTile(
      onTap: () async {
        final tracks = await GetAllTracks.call();
        final index = tracks.indexWhere((track) => track.id == this.track.id);

        PlayAudio.call(tracks, index: index);
      },
      leading: Container(
        width: Sizer.x5,
        height: Sizer.x5,
        decoration: BoxDecoration(
          image: track.artwork != null
              ? DecorationImage(image: Image.memory(track.artwork!).image)
              : null,
          borderRadius: BorderRadius.circular(Sizer.x0_5),
          color: theme.colorScheme.surfaceBright,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MoreIcon.vertical(
            title: track.title,
            subtitle: track.artist,
            image: track.artwork,
            tiles: [
              IsInFavourites.call(track)
                  ? RemoveFromFavTile(
                      track,
                      onTap: () => setState(() {
                        track.isFavourite = false;
                      }),
                    )
                  : AddToFavTile(
                      track,
                      onTap: () => setState(() {
                        track.isFavourite = true;
                      }),
                    ),
              AddToPlaylistTile(track: track),
              if (track.albumId != null) GoToAlbumTile(track.albumId!),
              if (track.artistId != null) GoToArtistTile(track.artistId!),
              FileDetailsTile(track: track),
            ],
          ),
        ],
      ),
      title: RetipUtils.getQueryText(context, track.title, widget.query ?? ''),
      subtitle: SingleLineText(
        track.artist,
      ),
    );
  }
}
