import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/domain/enitities/track_entity.dart';
import 'package:retip/app/domain/services/audio_service.dart';
import 'package:retip/app/presentation/widgets/cards/leading_list_tile_card_widget.dart';
import 'package:retip/app/presentation/widgets/texts/single_line_text_widget.dart';

class AddToQueueListTileWidget extends StatelessWidget {
  final TrackEntity track;

  const AddToQueueListTileWidget(this.track, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SingleLineTextWidget('Add to queue'),
      leading: LeadingListTileCardWidget(Icons.queue_music),
      onTap: () {
        Navigator.pop(context);
        context.read<AudioService>().addToQueue([track]);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"${track.title}" added to queue')),
        );
      },
    );
  }
}
