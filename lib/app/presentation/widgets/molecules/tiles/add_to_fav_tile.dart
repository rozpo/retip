import 'package:flutter/material.dart';
import 'package:retip/app/domain/cases/favourites/add_to_favourites.dart';
import 'package:retip/app/domain/entities/abstract_entity.dart';
import 'package:retip/app/presentation/widgets/molecules/more_tile.dart';
import 'package:retip/app/presentation/widgets/molecules/rp_snackbar.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class AddToFavTile extends StatelessWidget {
  final AbstractEntity entity;
  final VoidCallback? onTap;

  const AddToFavTile(
    this.entity, {
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return MoreTile(
      icon: Icons.favorite_outline,
      text: l10n.addToFavourites,
      onTap: () {
        Navigator.of(context).pop();
        AddToFavourites.call(entity);

        final message = l10n.addedTo(l10n.favourites.toLowerCase());
        final snackbar = RpSnackbar(context, message: message);

        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackbar);

        onTap?.call();
      },
    );
  }
}
