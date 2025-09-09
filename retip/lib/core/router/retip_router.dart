import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retip/app/presentation/cubits/dev/dev_cubit.dart';
import 'package:retip/app/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:retip/app/presentation/cubits/permissions/permissions_cubit.dart';

import '../../app/presentation/pages/pages.dart';
import '../../app/presentation/widgets/widgets.dart';
import '../logger/retip_logger.dart';
import 'retip_route.dart';

class RetipRouter extends GoRouter {
  final RetipLogger logger;

  RetipRouter(this.logger)
    : super.routingConfig(
        initialLocation: RetipRoute.home.location,
        observers: [logger.navigatorObserver],
        routingConfig: ValueNotifier(
          RoutingConfig(
            redirect: (context, state) {
              final permissionsCubit = context.read<PermissionsCubit>();
              final onboardingCubit = context.read<OnboardingCubit>();

              if (onboardingCubit.state.isDone == false) {
                return RetipRoute.onboarding.location;
              } else if (permissionsCubit.state.isGranted == false) {
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
                path: RetipRoute.profile.location,
                name: RetipRoute.profile.name,
                builder: (context, state) {
                  return ProfilePage();
                },
                routes: [
                  GoRoute(
                    path: RetipRoute.appinfo.location,
                    name: RetipRoute.appinfo.name,
                    builder: (context, state) {
                      return AppInfoPage();
                    },
                  ),
                  GoRoute(
                    path: RetipRoute.settings.location,
                    name: RetipRoute.settings.name,
                    builder: (context, state) {
                      final devCubit = context.read<DevCubit>();
                      return SettingsPage(devCubit: devCubit);
                    },
                    routes: [
                      GoRoute(
                        path: RetipRoute.dev.location,
                        name: RetipRoute.dev.name,
                        builder: (context, state) {
                          final devCubit = context.read<DevCubit>();
                          return DevPage(devCubit: devCubit);
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
                observers: [logger.navigatorObserver],
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
                    routes: [
                      GoRoute(
                        path: '${RetipRoute.album.location}/:id',
                        name: RetipRoute.album.name,
                        builder: (context, state) {
                          final id = state.pathParameters['id'] as String;
                          return AlbumPage(int.parse(id));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
