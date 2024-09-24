import 'package:flutter/material.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class AlbumsTab extends StatelessWidget {
  const AlbumsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(RetipL10n.of(context).albums),
      ),
    );
  }
}
