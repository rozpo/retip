import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_routes.dart';
import 'player_view.dart';

class HomeView extends StatefulWidget {
  final Widget child;

  const HomeView({required this.child, super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PlayerView(),
          BottomNavigationBar(
            currentIndex: _index,
            onTap: (value) {
              final route = switch (value) {
                0 => RetipRoutes.home,
                1 => RetipRoutes.search,
                2 => RetipRoutes.library,
                _ => RetipRoutes.home,
              };

              context.go(route);

              setState(() {
                _index = value;
              });
            },
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.search),
                label: 'Search',
                icon: Icon(Icons.search_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Library',
                activeIcon: Icon(Icons.library_music),
                icon: Icon(Icons.library_music_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
