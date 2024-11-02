import 'package:flutter/material.dart';
import 'package:retip/app/views/home/pages/favourites/favourites_page.dart';
import 'package:retip/app/views/home/pages/library/library_page.dart';
import 'package:retip/app/views/search/search_view.dart';
import 'package:retip/app/widgets/player_widget.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

import 'widgets/retip_icon.dart';

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
          SearchView(isSelected: () => focusSearch),
          const FavouritePage(),
          const LibraryPage(),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const PlayerWidget(),
          BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
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
                label: RetipL10n.of(context).home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.library_music),
                label: RetipL10n.of(context).library,
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
