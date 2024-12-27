import 'package:flutter/material.dart';
import 'package:retip/app/views/home/pages/home/home_page.dart';
import 'package:retip/app/views/home/pages/library/library_page.dart';
import 'package:retip/app/views/home/pages/search/search_page.dart';
import 'package:retip/app/views/settings/settings_page.dart';
import 'package:retip/app/widgets/player_widget.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

import '../../widgets/retip_icon.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController pageController = PageController(initialPage: 1);
  int index = 1;

  bool focusSearch = false;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          SearchPage(isSelected: () => focusSearch),
          const RetipPage(),
          const LibraryPage(),
          const SettingsPage(),
        ],
      ),
      bottomNavigationBar: Column(
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
                label: RetipL10n.of(context).search,
              ),
              BottomNavigationBarItem(
                activeIcon: RetipIcon(color: colorScheme.primary),
                icon: RetipIcon(color: colorScheme.outline),
                label: RetipL10n.of(context).retip,
              ),
              BottomNavigationBarItem(
                activeIcon: const Icon(Icons.library_music),
                icon: const Icon(Icons.library_music_outlined),
                label: RetipL10n.of(context).library,
              ),
              BottomNavigationBarItem(
                activeIcon: const Icon(Icons.settings),
                icon: const Icon(Icons.settings_outlined),
                label: RetipL10n.of(context).settings,
              ),
            ],
            currentIndex: index,
            onTap: (value) {
              index = value;

              if (index == 0) {
                focusSearch = true;
              } else {
                focusSearch = false;
              }

              setState(() {});

              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
    );
  }
}
