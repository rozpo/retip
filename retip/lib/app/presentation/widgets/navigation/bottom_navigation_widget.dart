import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/core/router/retip_route.dart';

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

        final nextLocation = switch (value) {
          2 => RetipRoute.library,
          1 => RetipRoute.search,
          0 || _ => RetipRoute.home,
        };

        context.go(nextLocation);
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music),
          label: 'Library',
        ),
      ],
    );
  }
}
