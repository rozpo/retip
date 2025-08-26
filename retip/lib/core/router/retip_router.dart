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

  RetipRouter()
    : super.routingConfig(
        initialLocation: '/',
        routingConfig: ValueNotifier(
          RoutingConfig(
            routes: [
              _profile,
              ShellRoute(
                builder: (context, state, child) {
                  return Scaffold(
                    body: child,
                    bottomNavigationBar: BottomNavigationWidget(),
                  );
                },
                routes: [_home, _search, _library],
              ),
            ],
          ),
        ),
      );
}
