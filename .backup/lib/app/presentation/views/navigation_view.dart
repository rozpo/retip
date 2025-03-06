import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/retip_l10n.dart';
import '../../../core/router/retip_router.dart';
import '../widgets/player_widget.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = RetipL10n.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const PlayerWidget(),
        BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            final destination = switch (value) {
              0 => RetipRouter.home,
              1 => RetipRouter.explore,
              2 => RetipRouter.search,
              3 => RetipRouter.library,
              4 => RetipRouter.profile,
              _ => RetipRouter.home,
            };

            context.go(destination);

            index = value;
            setState(() {});
          },
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: l10n.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.explore),
              label: l10n.explore,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: l10n.search,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.library_music),
              label: l10n.library,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: l10n.profile,
            ),
          ],
        ),
      ],
    );
  }
}
