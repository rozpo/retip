import 'package:flutter/material.dart';

import '../../domain/entities/track_entity.dart';
import 'atoms/icon_atom.dart';
import 'atoms/short_text_atom.dart';

class TrackOptions extends StatelessWidget {
  final TrackEntity track;

  const TrackOptions(
    this.track, {
    super.key,
  });

  Future<void> show(BuildContext context) async {
    return showModalBottomSheet(
      builder: (context) => this,
      useRootNavigator: true,
      useSafeArea: true,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const IconAtom(Icons.music_note),
            title: ShortTextAtom(track.title),
            subtitle: ShortTextAtom(track.artist!.name),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: const [
                ListTile(
                  leading: IconAtom(Icons.play_arrow),
                  title: Text('Play next'),
                ),
                ListTile(
                  leading: IconAtom(Icons.queue_music),
                  title: Text('Add to queue'),
                ),
                ListTile(
                  leading: IconAtom(Icons.favorite_outline),
                  title: Text('Add to favorites'),
                ),
                ListTile(
                  leading: IconAtom(Icons.playlist_add),
                  title: Text('Add to playlist'),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
                ListTile(
                  leading: IconAtom(Icons.person),
                  title: Text('Go to artist'),
                ),
                ListTile(
                  leading: IconAtom(Icons.album),
                  title: Text('Go to album'),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
                ListTile(
                  leading: IconAtom(Icons.sort),
                  title: Text('Sort by'),
                ),
                ListTile(
                  leading: IconAtom(Icons.grid_view),
                  title: Text('Grid view'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
