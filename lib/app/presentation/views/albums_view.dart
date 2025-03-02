import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_router.dart';

class AlbumsView extends StatelessWidget {
  const AlbumsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Album $index'),
          leading: const Icon(Icons.album),
          onTap: () => context.pushNamed(
            pathParameters: {'id': '$index'},
            RetipRouter.album,
          ),
        );
      },
    );
  }
}
