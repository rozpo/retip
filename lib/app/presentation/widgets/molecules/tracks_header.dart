import 'package:flutter/material.dart';
import '../atoms/spacer.dart';
import '../../../../core/l10n/retip_l10n.dart';

class TracksHeader extends StatelessWidget {
  final int value;

  const TracksHeader({
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.queue_music),
        const HorizontalSpacer(),
        Text(
          RetipL10n.of(context).tracksCount(value),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
