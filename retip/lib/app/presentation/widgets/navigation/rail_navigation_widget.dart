import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RailNavigationWidget extends StatefulWidget {
  const RailNavigationWidget({super.key});

  @override
  State<RailNavigationWidget> createState() => _RailNavigationWidgetState();
}

class _RailNavigationWidgetState extends State<RailNavigationWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      labelType: NavigationRailLabelType.all,
      selectedIndex: _index,
      onDestinationSelected: (int index) {
        setState(() {
          _index = index;
        });

        final destination = switch (index) {
          0 => '/',
          1 => '/search',
          2 => '/library',
          _ => '/',
        };

        context.go(destination);
      },
      destinations: [
        NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
        NavigationRailDestination(
          icon: Icon(Icons.search),
          label: Text('Search'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.library_music),
          label: Text('Library'),
        ),
      ],
    );
  }
}
