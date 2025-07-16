import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_routes.dart';
import '../../../domain/entites/track_entity.dart';

class TrackListTileWidget extends StatelessWidget {
  final TrackEntity track;
  final VoidCallback? onTap;

  const TrackListTileWidget({
    required this.track,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(track.title),
      subtitle: Text(track.artist),
      leading: const CircleAvatar(
        child: Icon(Icons.music_note),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          showModalBottomSheet(
            useRootNavigator: true,
            useSafeArea: true,
            context: context,
            builder: (context) {
              return Column(
                children: [
                  ListTile(
                    title: const Text('Go to artist'),
                    onTap: () {
                      context.pop();
                      context.pushNamed(
                        RetipRoutes.artist,
                        pathParameters: {
                          'id': track.artistId.toString(),
                        },
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Go to album'),
                    onTap: () {
                      context.pop();
                      context.pushNamed(
                        RetipRoutes.album,
                        pathParameters: {
                          'id': track.albumId.toString(),
                        },
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Show track info'),
                    onTap: () {
                      context.pop();
                      context.pushNamed(
                        RetipRoutes.track,
                        pathParameters: {
                          'id': track.trackId.toString(),
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
