import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/retip_l10n.dart';

class FavouritiesWidget extends StatelessWidget {
  final bool isFavourite;
  final VoidCallback onTap;

  const FavouritiesWidget({
    required this.isFavourite,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.read<RetipL10n>().of(context);

    return IconButton(
      icon: Icon(
        isFavourite ? Icons.favorite : Icons.favorite_outline,
      ),
      onPressed: () {
        onTap();
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isFavourite ? l10n.removedFromFavourites : l10n.addedToFavourites,
            ),
          ),
        );
      },
    );
  }
}
