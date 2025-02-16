import 'package:flutter/material.dart';
import '../../../../core/l10n/retip_l10n.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final void Function(int value)? onTap;

  const BottomNavigationBarWidget({
    this.onTap,
    super.key,
  });

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          widget.onTap?.call(value);
          setState(() => index = value);
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            activeIcon: const Icon(Icons.home),
            icon: const Icon(Icons.home_outlined),
            label: l10n.home,
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            activeIcon: const Icon(Icons.explore),
            icon: const Icon(Icons.explore_outlined),
            label: l10n.explore,
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            icon: const Icon(Icons.search_outlined),
            activeIcon: const Icon(Icons.search),
            label: l10n.search,
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            icon: const Icon(Icons.library_music_outlined),
            activeIcon: const Icon(Icons.library_music),
            label: l10n.library,
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: l10n.settings,
          ),
        ],
      ),
    );
  }
}
