import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_router.dart';

class ArtistsView extends StatelessWidget {
  const ArtistsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 25,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Artist $index'),
          leading: const Icon(Icons.person),
          onTap: () => context.pushNamed(
            pathParameters: {'id': '$index'},
            RetipRouter.artist,
          ),
        );
      },
    );
  }
}
