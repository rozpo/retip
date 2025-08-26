import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/presentation/pages/pages.dart';
import '../../app/presentation/widgets/widgets.dart';

class RetipRouter extends GoRouter {
  static final _home = GoRoute(
    path: '/',
    builder: (context, state) {
      return HomePage();
    },
  );

  static final _search = GoRoute(
    path: '/search',
    builder: (context, state) {
      return SearchPage();
    },
  );

  static final _library = GoRoute(
    path: '/library',
    builder: (context, state) {
      return LibraryPage();
    },
  );

  static final _profile = GoRoute(
    path: '/profile',
    builder: (context, state) {
      return ProfilePage();
    },
  );

  static final _player = GoRoute(
    path: '/player',
    builder: (context, state) {
      return PlayerPage();
    },
  );

  RetipRouter()
    : super.routingConfig(
        initialLocation: '/',
        routingConfig: ValueNotifier(
          RoutingConfig(
            routes: [
              _player,
              _profile,
              ShellRoute(
                builder: (context, state, child) {
                  return Scaffold(
                    body: child,
                    bottomNavigationBar: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [PlayerWidget(), BottomNavigationWidget()],
                    ),
                  );
                },
                routes: [_home, _search, _library],
              ),
            ],
          ),
        ),
      );
}
