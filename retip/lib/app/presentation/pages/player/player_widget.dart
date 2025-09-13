import 'package:flutter/material.dart';
import 'package:retip/app/presentation/widgets/texts/single_line_text_widget.dart';
import 'package:retip/core/router/retip_route.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(color: Theme.of(context).colorScheme.primary),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () => RetipRoute.player.push(context),
          leading: Card(
            child: SizedBox.square(
              dimension: 40,
              child: Icon(Icons.music_note),
            ),
          ),
          title: SingleLineTextWidget('Title'),
          subtitle: SingleLineTextWidget('Artist'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline)),
              IconButton.filledTonal(
                onPressed: () {},
                icon: Icon(Icons.play_arrow),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
