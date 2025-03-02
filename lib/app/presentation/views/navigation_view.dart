import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ],
    );
  }
}
