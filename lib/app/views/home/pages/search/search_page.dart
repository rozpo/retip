import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:retip/app/data/repositories/on_audio_query_artist_repository.dart';
import 'package:retip/app/services/entities/album_entity.dart';
import 'package:retip/app/services/entities/artist_entity.dart';
import 'package:retip/app/views/home/pages/album/album_page.dart';
import 'package:retip/app/views/home/pages/artist/artist_page.dart';
import 'package:retip/app/views/player/player_view.dart';
import 'package:retip/app/widgets/spacer.dart';
import 'package:retip/core/audio/retip_audio.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/utils/debouncer.dart';
import 'package:retip/core/utils/sizer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  final debouncer = Debouncer(const Duration(milliseconds: 500));

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List media = [];
  List artists = <ArtistEntity>[];
  bool searching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          autoFocus: true,
          hintText: '${RetipL10n.of(context).search}...',
          controller: controller,
          onChanged: (value) {
            debouncer.run(() async {
              setState(() {
                searching = true;
              });
              media.clear();

              if (controller.text.isEmpty) {
                setState(() {
                  searching = false;
                });
                return;
              }

              final query = controller.text.toLowerCase();
              if (artists.isEmpty) {
                artists = await OnAudioQueryArtistRepository().getAll();
              }

              for (final artist in artists) {
                if (artist.name.toLowerCase().contains(query)) {
                  media.add(artist);
                }

                for (final album in artist.albums) {
                  if (album.title.toLowerCase().contains(query)) {
                    media.add(album);
                  }

                  for (final track in album.tracks) {
                    if (track.title.toLowerCase().contains(query)) {
                      media.add(track);
                    }
                  }
                }
              }

              setState(() {
                searching = false;
              });
            });
          },
        ),
      ),
      body: searching
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: Sizer.x2),
              separatorBuilder: (context, index) {
                return const VerticalSpacer();
              },
              itemCount: media.length,
              itemBuilder: (context, index) {
                final item = media[index];
                String subtitle;

                if (item is AlbumEntity) {
                  subtitle = RetipL10n.of(context).album;
                } else if (item is ArtistEntity) {
                  subtitle = RetipL10n.of(context).artist;
                } else {
                  subtitle = RetipL10n.of(context).track;
                }

                return ListTile(
                  leading:
                      item.artwork != null ? Image.memory(item.artwork) : null,
                  title: Text(item.toString()),
                  subtitle: Text(subtitle),
                  onTap: () async {
                    if (item is ArtistEntity) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ArtistPage(artist: item);
                          },
                        ),
                      );
                    } else if (item is AlbumEntity) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return AlbumPage(album: item);
                          },
                        ),
                      );
                    } else {
                      final audio = GetIt.instance.get<RetipAudio>();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PlayerView(
                            player: audio,
                          ),
                        ),
                      );

                      await audio.playlistAddAll([item]);
                      await audio.stop();
                      await audio.seekToIndex(0);
                      await audio.play();
                    }
                  },
                );
              },
            ),
    );
  }
}
