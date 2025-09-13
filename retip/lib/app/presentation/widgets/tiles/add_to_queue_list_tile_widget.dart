import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/retip_l10n.dart';
import '../../../domain/enitities/track_entity.dart';
import '../../../domain/services/audio_service.dart';
import '../cards/leading_list_tile_card_widget.dart';

class AddToQueueListTileWidget extends StatelessWidget {
  final TrackEntity track;

  const AddToQueueListTileWidget(this.track, {super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return ListTile(
      title: Text(l10n.addToQueue),
      leading: LeadingListTileCardWidget(Icons.queue_music),
      onTap: () {
        Navigator.pop(context);
        context.read<AudioService>().addToQueue([track]);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"${track.title}" ${l10n.addedToQueue}')),
        );
      },
    );
  }
}
