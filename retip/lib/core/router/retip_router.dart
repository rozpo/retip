import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/app/presentation/views/home_view.dart';

import '../../app/presentation/pages/pages.dart';
import 'retip_routes.dart';

class RetipRouter extends GoRouter {
  RetipRouter()
    : super.routingConfig(
        initialLocation: RetipRoutes.home,
        routingConfig: ValueNotifier(
          RoutingConfig(
            routes: [
              GoRoute(
                path: RetipRoutes.player,
                builder: (context, state) => PlayerPage(),
              ),
              GoRoute(
                path: RetipRoutes.profile,
                builder: (context, state) => ProfilePage(),
              ),
              GoRoute(
                path: RetipRoutes.settings,
                builder: (context, state) => SettingsPage(),
              ),
              if (kReleaseMode == false) ...[
                GoRoute(
                  path: RetipRoutes.dev,
                  builder: (context, state) => DevPage(),
                ),
              ],
              ShellRoute(
                builder: (context, state, child) {
                  return HomeView(child: child);
                },
                routes: [
                  GoRoute(
                    path: RetipRoutes.home,
                    builder: (context, state) => HomePage(),
                  ),
                  GoRoute(
                    path: RetipRoutes.search,
                    builder: (context, state) => SearchPage(),
                  ),
                  GoRoute(
                    path: RetipRoutes.library,
                    builder: (context, state) => LibraryPage(),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
