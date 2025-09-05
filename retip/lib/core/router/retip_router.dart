import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/presentation/pages/pages.dart';
import '../../app/presentation/widgets/widgets.dart';
import 'retip_route.dart';

class RetipRouter extends GoRouter {
  RetipRouter()
    : super.routingConfig(
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
                routes: [
                  GoRoute(
                    path: RetipRoute.home,
                    builder: (context, state) {
                      return HomePage();
                    },
                  ),
                  GoRoute(
                    path: RetipRoute.search,
                    builder: (context, state) {
                      return SearchPage();
                    },
                  ),
                  GoRoute(
                    path: RetipRoute.library,
                    builder: (context, state) {
                      return LibraryPage();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
