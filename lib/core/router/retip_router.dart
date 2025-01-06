import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/app/views/dev/dev_view.dart';
import 'package:retip/app/views/home/home_view.dart';
import 'package:retip/app/views/into/intro_view.dart';
import 'package:retip/app/widgets/navigation/navigation_widget.dart';
import 'package:retip/core/constants/routes_constants.dart';

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
          return const IntroView();
        },
      ),
      ShellRoute(
        navigatorKey: shellNavKey,
        routes: [
          GoRoute(
            path: RoutesConstants.home,
            builder: (context, state) {
              return HomeView(pageController: pageController);
            },
            routes: [
              if (kReleaseMode == false) ...[
                GoRoute(
                  path: RoutesConstants.dev,
                  builder: (context, state) {
                    return const DevView();
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
