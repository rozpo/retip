import 'package:flutter/material.dart';
import 'package:retip/app/widgets/modal_bottom_sheet.dart';
import 'package:retip/app/widgets/option_list_tile.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

enum SortMode {
  numerically(icon: Icons.sort),
  alphabetically(icon: Icons.sort_by_alpha);

  final IconData icon;

  const SortMode({required this.icon});
}

class SortButton extends StatelessWidget {
  final SortMode sortMode;
  final VoidCallback sortByAlpha;
  final VoidCallback sortByNum;

  const SortButton({
    required this.sortMode,
    required this.sortByNum,
    required this.sortByAlpha,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(sortMode.icon),
      onPressed: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          context: context,
          builder: (context) {
            return ModalBottomSheet(
              options: [
                OptionListTile(
                  text: RetipL10n.of(context).sortByIndex,
                  icon: SortMode.numerically.icon,
                  onTap: sortByNum,
                ),
                OptionListTile(
                  text: RetipL10n.of(context).sortAlphabetically,
                  icon: SortMode.alphabetically.icon,
                  onTap: sortByAlpha,
                ),
              ],
            );
          },
        );
      },
    );
  }
}