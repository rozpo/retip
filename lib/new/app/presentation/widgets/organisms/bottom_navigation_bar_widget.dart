import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/retip_route.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        switch (value) {
          case 0:
            context.go(RetipRoute.home);
            break;
          case 1:
            context.go(RetipRoute.explore);
            break;
          case 2:
            context.go(RetipRoute.search);
            break;
          case 3:
            context.go(RetipRoute.library);
            break;
          case 4:
            context.go(RetipRoute.settings);
            break;
        }

        _index = value;
        setState(() {});
      },
      currentIndex: _index,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.explore),
          icon: Icon(Icons.explore_outlined),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.search),
          icon: Icon(Icons.search_outlined),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.library_music),
          icon: Icon(Icons.library_music_outlined),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.settings),
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
      ],
    );
  }
}
