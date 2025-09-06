import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/presentation/pages/pages.dart';
import '../../app/presentation/widgets/widgets.dart';
import 'retip_route.dart';

class RetipRouter extends GoRouter {
  static bool isOnboardingDone = false;
  static bool isPermissionsGranted = false;

  RetipRouter()
    : super.routingConfig(
        initialLocation: RetipRoute.home,
        routingConfig: ValueNotifier(
          RoutingConfig(
            redirect: (context, state) {
              if (isOnboardingDone == false) {
                return RetipRoute.onboarding;
              } else if (isPermissionsGranted == false) {
                return RetipRoute.permissions;
              }

              return null;
            },
            routes: [
              GoRoute(
                path: RetipRoute.onboarding,
                builder: (context, state) {
                  return OnboardingPage();
                },
              ),
              GoRoute(
                path: RetipRoute.settings,
                builder: (context, state) {
                  return SettingsPage();
                },
              ),
              GoRoute(
                path: RetipRoute.permissions,
                builder: (context, state) {
                  return PermissionsPage();
                },
              ),
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
