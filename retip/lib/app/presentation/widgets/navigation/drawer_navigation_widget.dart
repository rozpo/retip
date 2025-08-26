import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerNavigationWidget extends StatelessWidget {
  const DrawerNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Home'),
            onTap: () {
              context.pop();
              context.go('/');
            },
          ),
          ListTile(
            title: Text('Search'),
            onTap: () {
              context.pop();
              context.go('/search');
            },
          ),
          ListTile(
            title: Text('Library'),
            onTap: () {
              context.pop();
              context.go('/library');
            },
          ),
        ],
      ),
    );
  }
}
