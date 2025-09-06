import 'package:flutter/material.dart';

import '../../../../core/l10n/retip_l10n.dart';
import '../../../../core/router/retip_route.dart';

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

        nextLocation.go(context);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: RetipL10n.of(context).home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: RetipL10n.of(context).search,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music),
          label: RetipL10n.of(context).library,
        ),
      ],
    );
  }
}
