import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/retip_l10n.dart';
import '../../../core/router/retip_routes.dart';
import '../widgets/retip_logo_widget.dart';
// import '../widgets/player_widget.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.read<RetipL10n>().of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // const PlayerWidget(),
        Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: RetipLogoWidget(
                  width: 24,
                  height: 24,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor,
                ),
                activeIcon: RetipLogoWidget(
                  width: 24,
                  height: 24,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor,
                ),
                label: l10n.home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.explore_outlined),
                activeIcon: const Icon(Icons.explore),
                label: l10n.explore,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.search_outlined),
                activeIcon: const Icon(Icons.search),
                label: l10n.search,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.library_music_outlined),
                activeIcon: const Icon(Icons.library_music),
                label: l10n.library,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                activeIcon: const Icon(Icons.person),
                label: l10n.profile,
              ),
            ],
            currentIndex: index,
            onTap: (value) {
              final destination = switch (value) {
                0 => RetipRoutes.home,
                1 => RetipRoutes.explore,
                2 => RetipRoutes.search,
                3 => RetipRoutes.library,
                4 => RetipRoutes.profile,
                _ => RetipRoutes.home,
              };

              context.go(destination);

              index = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
