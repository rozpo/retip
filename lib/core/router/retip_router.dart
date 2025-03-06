import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/domain/repositories/permission_repository.dart';
import '../../app/presentation/cubits/onboarding/onboarding_cubit.dart';
import '../../app/presentation/pages/home_page.dart';
import '../../app/presentation/pages/onboarding_page.dart';
import '../../app/presentation/pages/permission_page.dart';
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

  static Future<String?> _redirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final permissionRepository = context.read<PermissionRepository>();
    final onboardingCubit = context.read<OnboardingCubit>();

    if (onboardingCubit.state is! OnboardingFinished) {
      return RetipRoutes.onboarding;
    }

    if (await permissionRepository.getMediaPermissionStatus() == false) {
      return RetipRoutes.permission;
    }

    return null;
  }

  RetipRouter()
      : super.routingConfig(
          routingConfig: ValueNotifier(
            RoutingConfig(
              redirect: _redirect,
              routes: [
                _home,
                _onboarding,
                _permission,
              ],
            ),
          ),
        );
}
