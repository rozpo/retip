import 'package:flutter/material.dart';
import 'package:retip/app/widgets/player_widget.dart';
import 'package:retip/app/widgets/retip_icon.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/router/retip_router.dart';

class NavigationWidget extends StatefulWidget {
  final PageController pageController;
  final void Function(int index)? onTap;

  const NavigationWidget({
    required this.pageController,
    this.onTap,
    super.key,
  });

  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  int index = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = RetipL10n.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const PlayerWidget(),
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: colorScheme.surfaceContainer,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: colorScheme.outline,
          fixedColor: colorScheme.primary,
          items: [
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.search),
              icon: const Icon(Icons.search_outlined),
              label: l10n.search,
            ),
            BottomNavigationBarItem(
              activeIcon: RetipIcon(color: colorScheme.primary),
              icon: RetipIcon(color: colorScheme.outline),
              label: l10n.retip,
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.library_music),
              icon: const Icon(Icons.library_music_outlined),
              label: l10n.library,
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.settings),
              icon: const Icon(Icons.settings_outlined),
              label: l10n.settings,
            ),
          ],
          currentIndex: index,
          onTap: (value) {
            index = value;

            final shellContext = RetipRouter.shellNavKey.currentContext;

            while (shellContext != null && Navigator.canPop(shellContext)) {
              Navigator.pop(shellContext);
            }

            setState(() {});
            widget.pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }
}
