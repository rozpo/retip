import 'package:flutter/material.dart';

class TrackSheetWidget extends StatelessWidget {
  const TrackSheetWidget({super.key});

  Future<void> show(BuildContext context) async {
    return showModalBottomSheet(
      scrollControlDisabledMaxHeightRatio: 0.9,
      isScrollControlled: true,
      shape: const ContinuousRectangleBorder(),
      builder: (context) => this,
      useRootNavigator: true,
      useSafeArea: true,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ListTile(
          title: Text('Title of the track'),
          subtitle: Text('Artist name'),
          leading: Icon(Icons.music_note),
          trailing: Icon(Icons.info_outline),
        ),
        const Divider(),
        ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: const Text('Add to queue'),
              onTap: () {},
              leading: const Icon(Icons.queue_music),
            ),
            ListTile(
              title: const Text('Add to playlist'),
              onTap: () {},
              leading: const Icon(Icons.playlist_add),
            ),
            ListTile(
              title: const Text('Add to favorites'),
              onTap: () {},
              leading: const Icon(Icons.favorite_outline),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.album),
              title: const Text('Go to album'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Go to artist'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.music_off),
              title: const Text('Hide track'),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
