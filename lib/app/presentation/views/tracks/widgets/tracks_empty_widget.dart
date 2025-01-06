import 'package:flutter/material.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class TracksEmptyWidget extends StatelessWidget {
  const TracksEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return Center(
      child: Text(l10n.noTracks),
    );
  }
}
