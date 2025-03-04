import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/domain/repositories/config_repository.dart';
import '../../app/presentation/pages/pages.dart';
import 'retip_routes.dart';

class RetipRouter extends GoRouter {
  static final _home = GoRoute(
    builder: (context, state) => const HomePage(),
    path: RetipRoutes.home,
  );

  static final _onboarding = GoRoute(
    builder: (context, state) => const OnboardingPage(),
    path: RetipRoutes.onboarding,
  );

  static final _permission = GoRoute(
    builder: (context, state) => const PermissionPage(),
    path: RetipRoutes.permission,
  );

  RetipRouter()
      : super.routingConfig(
          routingConfig: ValueNotifier(
            RoutingConfig(
              redirect: (context, state) {
                if (context.read<ConfigRepository>().getOnboardingStatus()) {
                  return RetipRoutes.onboarding;
                }

                return null;
              },
              routes: [
                _home,
                _onboarding,
                _permission,
              ],
            ),
          ),
        );
}
