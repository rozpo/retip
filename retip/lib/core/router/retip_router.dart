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
        initialLocation: RetipRoute.home.location,
        routingConfig: ValueNotifier(
          RoutingConfig(
            redirect: (context, state) {
              if (isOnboardingDone == false) {
                return RetipRoute.onboarding.location;
              } else if (isPermissionsGranted == false) {
                return RetipRoute.permissions.location;
              }

              return null;
            },
            routes: [
              GoRoute(
                path: RetipRoute.onboarding.location,
                name: RetipRoute.onboarding.name,
                builder: (context, state) {
                  return OnboardingPage();
                },
              ),
              GoRoute(
                path: RetipRoute.settings.location,
                name: RetipRoute.settings.name,
                builder: (context, state) {
                  return SettingsPage();
                },
                routes: [
                  GoRoute(
                    path: RetipRoute.dev.location,
                    name: RetipRoute.dev.name,
                    builder: (context, state) {
                      return DevPage();
                    },
                  ),
                  GoRoute(
                    path: RetipRoute.logger.location,
                    name: RetipRoute.logger.name,
                    builder: (context, state) {
                      return LoggerPage();
                    },
                  ),
                ],
              ),
              GoRoute(
                path: RetipRoute.permissions.location,
                name: RetipRoute.permissions.name,
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
                    path: RetipRoute.home.location,
                    name: RetipRoute.home.name,
                    builder: (context, state) {
                      return HomePage();
                    },
                  ),
                  GoRoute(
                    path: RetipRoute.search.location,
                    name: RetipRoute.search.name,
                    builder: (context, state) {
                      return SearchPage();
                    },
                  ),
                  GoRoute(
                    path: RetipRoute.library.location,
                    name: RetipRoute.library.name,
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
