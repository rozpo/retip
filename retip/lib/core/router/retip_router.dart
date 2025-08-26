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

  RetipRouter()
    : super.routingConfig(
        initialLocation: '/',
        routingConfig: ValueNotifier(
          RoutingConfig(
            routes: [
              ShellRoute(
                builder: (context, state, child) {
                  return Scaffold(
                    body: child,
                    bottomNavigationBar: BottomNavigationWidget(),
                  );
                },
                routes: [_home],
              ),
            ],
          ),
        ),
      );
}
