import 'package:flutter/material.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.favourites),
      ),
      body: const Placeholder(),
    );
  }
}
