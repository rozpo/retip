import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_router.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final router = context.read<RetipRouter>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                context.push(router.playlist);
              },
              child: const Text('Platlist'),
            ),
            FilledButton(
              onPressed: () {
                context.push(router.album);
              },
              child: const Text('Album'),
            ),
            FilledButton(
              onPressed: () {
                context.push(router.artist);
              },
              child: const Text('Artist'),
            ),
            FilledButton(
              onPressed: () {
                context.push(router.genre);
              },
              child: const Text('Genre'),
            ),
          ],
        ),
      ),
    );
  }
}
