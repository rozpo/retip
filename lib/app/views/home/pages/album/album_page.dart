import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/views/player/player_view.dart';
import 'package:retip/core/asset/retip_asset.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlbumPage extends StatefulWidget {
  final AlbumEntity album;

  const AlbumPage({
    required this.album,
    super.key,
  });

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height / 3,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.album.title),
              background: widget.album.artwork != null
                  ? Image.memory(
                      widget.album.artwork!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      RetipAsset.logo,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SliverList.builder(
            itemCount: widget.album.tracks.length,
            itemBuilder: (context, index) {
              final prefs = GetIt.I.get<SharedPreferences>();
              final favouriteTracks =
                  prefs.getStringList('favourite_tracks') ?? [];

              final track = widget.album.tracks[index];
              track.isFavourite = favouriteTracks.contains(track.id.toString());

              return ListTile(
                title: Text(track.title),
                subtitle: Text(track.artist),
                trailing: IconButton(
                  onPressed: () async {
                    if (track.isFavourite) {
                      favouriteTracks.remove(track.id.toString());
                    } else {
                      favouriteTracks.add(track.id.toString());
                    }

                    await prefs.setStringList(
                        'favourite_tracks', favouriteTracks);

                    setState(() {});
                  },
                  icon: Icon(
                    track.isFavourite ? Icons.favorite : Icons.favorite_border,
                  ),
                ),
                onTap: () async {
                  final audio = GetIt.instance.get<RetipAudio>();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PlayerView(
                        player: audio,
                      ),
                    ),
                  );

                  await audio.playlistAddAll(widget.album.tracks);
                  await audio.stop();
                  await audio.seekToIndex(index);
                  await audio.play();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
