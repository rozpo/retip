import 'package:flutter/material.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class FavouriteButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isFavourite;

  const FavouriteButton({
    this.isFavourite = false,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.iconButtonTheme.style;

    final l10n = RetipL10n.of(context);
    final favourite = l10n.favourites.toLowerCase();

    return IconButton(
      icon: Icon(
        isFavourite ? Icons.favorite : Icons.favorite_outline,
      ),
      style: style?.copyWith(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed != null
          ? () {
              onPressed?.call();

              final snackBar = SnackBar(
                backgroundColor: theme.colorScheme.surfaceContainer,
                duration: const Duration(seconds: 1),
                content: Text(
                  isFavourite
                      ? l10n.removedFrom(favourite)
                      : l10n.addedTo(favourite),
                  style: theme.textTheme.bodyMedium,
                ),
              );
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          : null,
    );
  }
}
