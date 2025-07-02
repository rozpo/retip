import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/app/presentation/pages/dev/dev_page.dart';
import 'package:retip/app/presentation/pages/intro/intro_page.dart';
import 'package:retip/app/presentation/views/home/home_view.dart';
import 'package:retip/app/presentation/views/library/library_view.dart';
import 'package:retip/app/presentation/views/search/search_view.dart';
import 'package:retip/app/presentation/widgets/organisms/navigation_widget.dart';
import 'package:retip/core/constants/routes_constants.dart';

import 'retip_route.dart';

mixin RetipRouter {
  static final rootNavKey = GlobalKey<NavigatorState>();
  static final shellNavKey = GlobalKey<NavigatorState>();
  static final PageController pageController = PageController(initialPage: 1);

  static GoRouter router = GoRouter(
    navigatorKey: rootNavKey,
    initialLocation: RoutesConstants.intro,
    routes: [
      GoRoute(
        path: RoutesConstants.intro,
        builder: (context, state) {
          return const IntroPage();
        },
      ),
      ShellRoute(
        navigatorKey: shellNavKey,
        routes: [
          GoRoute(
            path: RetipRoute.library,
            builder: (context, state) {
              return const LibraryView();
            },
          ),
          GoRoute(
            path: RetipRoute.search,
            builder: (context, state) {
              return const SearchView();
            },
          ),
          GoRoute(
            path: RetipRoute.home,
            builder: (context, state) {
              return const HomeView();
            },
            routes: [
              if (kReleaseMode == false) ...[
                GoRoute(
                  path: RoutesConstants.dev,
                  builder: (context, state) {
                    return const DevPage();
                  },
                ),
              ],
            ],
          ),
        ],
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: NavigationWidget(
              pageController: pageController,
            ),
          );
        },
      ),
    ],
  );
}
