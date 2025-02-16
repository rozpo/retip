import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../cases/favourites/is_in_favourites.dart';
import '../cases/get_all_tracks.dart';
import '../cases/play_audio.dart';
import '../../presentation/widgets/atoms/more_icon.dart';
import '../../presentation/widgets/atoms/single_line_text.dart';
import '../../presentation/widgets/molecules/tiles/add_to_fav_tile.dart';
import '../../presentation/widgets/molecules/tiles/go_to_album_tile.dart';
import '../../presentation/widgets/molecules/tiles/go_to_artist_tile.dart';
import '../../presentation/widgets/molecules/tiles/remove_from_fav_tile.dart';
import '../../../core/l10n/retip_l10n.dart';
import '../../../core/utils/sizer.dart';
import '../../../core/utils/utils.dart';

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
  ListTile toListTile(BuildContext context, [String? query]) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: () async {
        final tracks = await GetAllTracks.call();
        final index = tracks.indexWhere((track) => track.id == id);

        PlayAudio.call(tracks, index: index);
      },
      leading: Container(
        width: Sizer.x5,
        height: Sizer.x5,
        decoration: BoxDecoration(
          image: artwork != null
              ? DecorationImage(image: Image.memory(artwork!).image)
              : null,
          borderRadius: BorderRadius.circular(Sizer.x0_5),
          color: theme.colorScheme.surfaceBright,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MoreIcon.horizontal(
            title: title,
            subtitle: artist,
            image: artwork,
            tiles: [
              IsInFavourites.call(this)
                  ? RemoveFromFavTile(
                      this,
                    )
                  : AddToFavTile(this),
              if (albumId != null) GoToAlbumTile(albumId!),
              if (artistId != null) GoToArtistTile(artistId!),
            ],
          ),
        ],
      ),
      title: RetipUtils.getQueryText(context, title, query ?? ''),
      subtitle: SingleLineText(
        artist,
      ),
    );
  }
}
