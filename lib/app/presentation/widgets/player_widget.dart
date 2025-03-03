import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_router.dart';
import 'buttons/play_pause_button_widget.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: Theme.of(context).colorScheme.surfaceBright,
              ),
            ),
          ],
        ),
        ListTile(
          leading: const Icon(Icons.music_note),
          title: const Text('Track title'),
          subtitle: const Text('Artist name'),
          trailing: PlayPauseButtonWidget(
            stream: Stream.value(true),
            onPressed: () => context.push(RetipRouter.player),
          ),
          onTap: () => context.push(RetipRouter.player),
        ),
      ],
    );
  }
}
