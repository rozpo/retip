import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              height: 1,
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
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
                  child: Container(height: 0),
                ),
              ],
            ),
            ListTile(
              onTap: () {},
              leading: Container(
                color: Theme.of(context).colorScheme.surfaceContainer,
                width: 40,
                height: 40,
                child: const Icon(Icons.music_note),
              ),
              title: const Text('Track title'),
              subtitle: const Text('Artist'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    style: Theme.of(context).iconButtonTheme.style,
                    icon: const Icon(
                      Icons.favorite_outline,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    style: Theme.of(context).iconButtonTheme.style,
                    icon: Icon(
                      Icons.play_arrow,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
