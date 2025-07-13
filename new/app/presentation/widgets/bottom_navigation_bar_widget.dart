import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/retip_routes.dart';
import '../views/player_view.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final Widget child;
  const BottomNavigationBarWidget({required this.child, super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const PlayerView(),
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
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_music),
                label: 'Library',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
