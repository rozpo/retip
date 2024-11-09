import 'package:flutter/material.dart';
import 'package:retip/app/services/cases/favourites/remove_from_favourites.dart';
import 'package:retip/app/services/entities/abstract_entity.dart';
import 'package:retip/app/widgets/more/more_tile.dart';
import 'package:retip/app/widgets/rp_snackbar.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class RemoveFromFavTile extends StatelessWidget {
  final AbstractEntity entity;
  final VoidCallback? onTap;

  const RemoveFromFavTile(
    this.entity, {
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return MoreTile(
      icon: Icons.favorite,
      text: l10n.removeFromFavourites,
      onTap: () {
        RemoveFromFavourites.call(entity);

        final message = l10n.removedFrom(l10n.favourites.toLowerCase());
        final snackbar = RpSnackbar(context, message: message);

        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackbar);

        onTap?.call();
      },
    );
  }
}
