import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _index,
      onTap: (value) {
        setState(() {
          _index = value;
        });

        final destination = switch (value) {
          0 => '/',
          1 => '/search',
          2 => '/library',
          _ => '/',
        };

        context.go(destination);
      },
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
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
      ],
    );
  }
}
