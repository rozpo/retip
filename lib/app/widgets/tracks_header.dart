import 'package:flutter/material.dart';
import 'package:retip/app/widgets/spacer.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class TracksHeader extends StatelessWidget {
  final int? value;

  const TracksHeader({
    this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.queue_music),
        const HorizontalSpacer(),
        Text(
          '${value ?? ''} ${RetipL10n.of(context).tracks}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
