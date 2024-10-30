import 'package:flutter/material.dart';
import 'package:retip/app/views/home/pages/favourites/favourites_page.dart';
import 'package:retip/app/views/home/pages/library/library_page.dart';
import 'package:retip/app/views/search/search_view.dart';
import 'package:retip/app/widgets/player/player_widget.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

import 'widgets/retip_icon.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController pageController = PageController();
  int index = 0;

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
          const FavouritePage(),
          SearchView(isSelected: () => focusSearch),
          const LibraryPage(),
        ],
      ),
      bottomSheet: const PlayerWidget(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: colorScheme.outline,
        fixedColor: colorScheme.primary,
        items: [
          BottomNavigationBarItem(
            activeIcon: RetipIcon(color: colorScheme.primary),
            icon: RetipIcon(color: colorScheme.outline),
            label: RetipL10n.of(context).home,
          ),
          BottomNavigationBarItem(
            activeIcon: const Icon(Icons.search),
            icon: const Icon(Icons.search_outlined),
            label: RetipL10n.of(context).search,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.library_music),
            label: RetipL10n.of(context).library,
          ),
        ],
        currentIndex: index,
        onTap: (value) {
          index = value;

          if (index == 1) {
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
    );
  }
}
