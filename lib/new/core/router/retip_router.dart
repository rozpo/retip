import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/domain/usecases/config_usecase.dart';
import '../../app/domain/usecases/permission_usecase.dart';
import '../../app/presentation/pages/explore/explore_page.dart';
import '../../app/presentation/pages/home/home_page.dart';
import '../../app/presentation/pages/library/library_page.dart';
import '../../app/presentation/pages/onboarding/onboarding_page.dart';
import '../../app/presentation/pages/permission/permission_page.dart';
import '../../app/presentation/pages/search/search_page.dart';
import '../../app/presentation/pages/settings/settings_page.dart';
import '../../app/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'retip_route.dart';

class RetipRouter extends GoRouter {
  static final rootNavKey = GlobalKey<NavigatorState>();
  static final shellNavKey = GlobalKey<NavigatorState>();

  RetipRouter()
      : super.routingConfig(
          navigatorKey: rootNavKey,
          initialLocation: RetipRoute.home,
          routingConfig: ValueNotifier(
            RoutingConfig(
              redirect: (context, state) async {
                final config = context.read<ConfigUsecase>();
                final showOnboarding = config.showOnboarding();

                if (showOnboarding) return RetipRoute.onboarding;

                final permission = context.read<PermissionUsecase>();
                final hasPermission = await permission.hasMediaPermission();

                return hasPermission == false ? RetipRoute.permission : null;
              },
              routes: [
                ShellRoute(
                  navigatorKey: shellNavKey,
                  builder: (context, state, child) {
                    return Scaffold(
                      body: child,
                      bottomNavigationBar: const BottomNavigationBarWidget(),
                    );
                  },
                  routes: [
                    RetipRoute(
                      path: RetipRoute.home,
                      builder: (context, state) {
                        return const HomePage();
                      },
                    ),
                    RetipRoute(
                      path: RetipRoute.explore,
                      builder: (context, state) {
                        return const ExplorePage();
                      },
                    ),
                    RetipRoute(
                      path: RetipRoute.search,
                      builder: (context, state) {
                        return const SearchPage();
                      },
                    ),
                    RetipRoute(
                      path: RetipRoute.library,
                      builder: (context, state) {
                        return const LibraryPage();
                      },
                    ),
                    RetipRoute(
                      path: RetipRoute.settings,
                      builder: (context, state) {
                        return const SettingsPage();
                      },
                    ),
                  ],
                ),
                RetipRoute(
                  path: RetipRoute.onboarding,
                  builder: (context, state) {
                    return const OnboardingPage();
                  },
                ),
                RetipRoute(
                  path: RetipRoute.permission,
                  builder: (context, state) {
                    return const PermissionPage();
                  },
                ),
              ],
            ),
          ),
        );
}
